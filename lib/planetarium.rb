require 'yaml'
require 'erb'
require 'feedzirra'

module Planetarium
  VERSION = "0.0.2"
  
  def self.configuration
    YAML::load_file("config/config.yml")
  end
end
