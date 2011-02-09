module Planetarium
  module Base
    def self.config
      YAML::load_file("../config/config.yml")
    end
  end
end
