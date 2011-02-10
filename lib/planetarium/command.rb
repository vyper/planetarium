module Planetarium
  module Command
    def self.update
      config  = Planetarium::Base.config
      name    = config['name']
      urls    = config['urls']
      version = Planetarium::VERSION

      feeds = Feedzirra::Feed.fetch_and_parse(config['urls']).each_value

      File.open("#{config["export_path"]}/index.html", "w") do |out|
        t = ERB.new(File.read("#{TEMPLATE_PATH}/#{config['template']}/index.html.erb"), 0, "%<>")
        out.puts t.result(binding)
      end
    end
    
    def self.add(url)
      Planetarium::Base.add url
    end
    
    def self.del(url)
      Planetarium::Base.del url
    end
    
    def self.list
      config = Planetarium::Base.config
      puts "Feeds in planetarium:"
      config['urls'].each { |u| puts " - #{u}" }
    end
  end
end
