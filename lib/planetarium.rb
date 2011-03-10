require 'rubygems'
require 'yaml'
require 'erb'
require 'feedzirra'
require 'main'
require 'planetarium/config'
require 'planetarium/command'
require 'planetarium/plugin'
require 'planetarium/model/feed'
require 'planetarium/model/entry'

module Planetarium
  VERSION       = "0.0.9"
  
  # configuration default
  CONFIG_FILE   = "#{File.dirname(__FILE__)}/../config/config.yml"
  TEMPLATE_PATH = "#{File.dirname(__FILE__)}/../templates"
end
