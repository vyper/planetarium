module Planetarium
  class Config
    attr_accessor :username
  end
end

module Planetarium
  module Plugin
    class Twitter
      include Planetarium::Plugin::Base
      
      def search(options)
        [] #TODO: structure base for plugin 
      end
      
      def plugin_name
        :twitter
      end
    end
  end
end
