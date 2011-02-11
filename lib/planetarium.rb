require 'rubygems'
require 'yaml'
require 'erb'
require 'feedzirra'
require 'main'
require 'planetarium/base'
require 'planetarium/command'

module Planetarium
  VERSION       = "0.0.4"
  
  # configuration default
  CONFIG_FILE   = "#{File.dirname(__FILE__)}/../config/config.yml"
  TEMPLATE_PATH = "#{File.dirname(__FILE__)}/../templates/"
end
