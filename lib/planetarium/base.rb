module Planetarium
  module Base
    def self.config
      YAML::load_file(CONFIG_FILE)
    end
    
    def self.add url
      config = self.config
      config['urls'] << url

      File.open(CONFIG_FILE, "w+") do |f|
        f << YAML::dump(config)
      end
    end
    
    def self.del url
      config = self.config
      config['urls'].delete url

      File.open(CONFIG_FILE, "w+") do |f|
        f << YAML::dump(config)
      end
    end
  end
end
