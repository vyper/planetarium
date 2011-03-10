module Planetarium
  module Model
    class Feed
      attr_accessor :url, :title, :feed_url, :last_modified

      def initialize(url, title, feed_url, last_modified)
        @url = url
        @title = title
        @feed_url = feed_url
        @last_modified = last_modified
      end
    end
  end
end
