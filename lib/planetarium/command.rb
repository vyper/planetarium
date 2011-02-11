module Planetarium
  module Command
    def self.update(config, options)
      @config = config if !config.nil?
      
      config = Planetarium::Base.config

      name        = config['name']
      urls        = config['urls']
      version     = Planetarium::VERSION
      
      if options[:export_path].nil?
        export_path = config["export_path"]
      else 
        export_path = options[:export_path]
      end
      
      if options[:template].nil?
        template = config["template"]
      else 
        template = options[:template]
      end
      
      feeds = Feedzirra::Feed.fetch_and_parse(config['urls']).each_value
    
      File.open("#{export_path}/index.html", "w") do |out|
        t = ERB.new(File.read("#{TEMPLATE_PATH}/#{template}/index.html.erb"), 0, "%<>")
        out.puts t.result(binding)
      end
    end
    
    def self.add(config, url)
      @config = config if !config.nil?
      Planetarium::Base.add url
    end
    
    def self.del(config, url)
      @config = config if !config.nil?
      Planetarium::Base.del url
    end
    
    def self.config(config, command, options)
      @config = config if !config.nil?

      if command.eql? "set"
        Planetarium::Base.config = options
      elsif command.eql? "list"
        # TODO improve visualization
        Planetarium::Base.config.each do |k, v|
          puts "#{k}: #{v}"
        end
      end
    end
    
    def self.list(config)
      @config = config if !config.nil?
      config = Planetarium::Base.config
      puts "Feeds in planetarium:"
      config['urls'].each { |u| puts " - #{u}" }
    end
  end
end
