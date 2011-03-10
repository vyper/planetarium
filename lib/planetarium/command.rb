module Planetarium
  module Command
    def self.update(config, options)
      config = Planetarium::Config.new(config)

      name        = config.name
      title       = config.title
      url         = config.url
      urls        = config.urls
      updated     = Time.new
      version     = Planetarium::VERSION
      
      if options[:export_path].nil?
        export_path = config.export_path
      else 
        export_path = options[:export_path]
      end
      
      if options[:template].nil?
        template = config.template
      else 
        template = options[:template]
      end
      
      if !File.exists? export_path
        puts "ERROR: export_path (#{export_path}) don't exists"
      elsif !File.writable? export_path
        puts "ERROR: no access to write in export_path (#{export_path})"
      elsif !File.exists? "#{TEMPLATE_PATH}/#{template}"
        puts "ERROR: template (#{template}) don't exists"
      else
        feeds   = []
        entries = []
        Feedzirra::Feed.fetch_and_parse(config.urls).each_value do |f|
          feed = Planetarium::Model::Feed.new f.url, f.title, f.feed_url, f.last_modified
          feeds << feed

          f.entries.each do |e|
            entry = Planetarium::Model::Entry.new e.id, e.title, e.author, e.published, e.content, e.url, e.updated, e.summary, feed
            entries << entry
          end
        end
        entries = entries.sort_by { |o| o.published }
        entries.reverse!

        # loading plugins
        # TODO: - improve load
        #       - loader plugin with marked enable
        plugins = {}
        Dir.glob("#{File.dirname(__FILE__)}/plugins/*.rb").each { |file| require file }
        Planetarium::Plugin::Base.repository.each do |r|
          p = r.new
          plugins[p.plugin_name] = p
        end

        # export html
        File.open("#{export_path}/index.html", "w") do |out|
          t = ERB.new(File.read("#{TEMPLATE_PATH}/#{template}/index.html.erb"), 0, "%<>")
          out.puts t.result(binding)
        end

        # export atom
        File.open("#{export_path}/atom.xml", "w") do |out|
          t = ERB.new(File.read("#{TEMPLATE_PATH}/atom.xml.erb"), 0, "%<>")
          out.puts t.result(binding)
        end
      end
    end
    
    def self.add(config, url)
      config = Planetarium::Config.new(config)
      config.urls << url
      config.save
    end
    
    def self.del(config, url)
      config = Planetarium::Config.new(config)
      config.urls.delete url
      config.save
    end
    
    def self.config(config, command, options)
      config = Planetarium::Config.new(config)

      if command.eql? "set"
        config.name        = options[:name]        if !options[:name].nil?
        config.title       = options[:title]       if !options[:title].nil?
        config.url         = options[:url]         if !options[:url].nil?
        config.template    = options[:template]    if !options[:template].nil?    # TODO check template exists
        config.export_path = options[:export_path] if !options[:export_path].nil? # TODO check path exists
        config.save
      elsif command.eql? "list"
        puts "name       : #{config.name}"
        puts "title      : #{config.title}"
        puts "url        : #{config.url}"
        puts "template   : #{config.template}"
        puts "export_path: #{config.export_path}"
        puts "urls: "
        config.urls.each { |u| puts " - #{u}" }
      end
    end
    
    def self.list(config)
      config = Planetarium::Config.new(config)
      puts "Feeds in planetarium:"
      config.urls.each { |u| puts " - #{u}" }
    end
  end
end
