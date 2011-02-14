module Planetarium
  module Base
    def self.config
      if @config.nil?
        config = YAML::load_file(CONFIG_FILE)
      else
        config = YAML::load_file(@config)
      end

      config
    end
    
    def self.config=(options)
      config = self.config

      config["name"]        = options[:name]        if !options[:name].nil?
      config["title"]       = options[:title]       if !options[:title].nil?
      config["url"]         = options[:url]         if !options[:url].nil?
      config["template"]    = options[:template]    if !options[:template].nil?    # TODO check template exists
      config["export_path"] = options[:export_path] if !options[:export_path].nil? # TODO check path exists

      self.write_config(config)
    end

    def self.add config, url
      config = self.config
      config["urls"] << url
      self.write_config(config)
    end
    
    def self.del url
      config = self.config
      config["urls"].delete url
      self.write_config(config)
    end
    
    private
      def self.write_config config
        File.open(CONFIG_FILE, "w+") do |f|
          f << YAML::dump(config)
        end
      end
  end
end
