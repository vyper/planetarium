module Planetarium
  module Plugin
    module Base
      def self.included(base)
        @repository = [] if !@repository.is_a? Array
        @repository << base
      end
  
      def self.repository
        @repository
      end
    end
  end
end
