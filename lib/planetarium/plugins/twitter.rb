module Planetarium
  module Plugin
    class Twitter
      include Planetarium::Plugin::Base

      def search(options)
        list = []
        
        twitter = Feedzirra::Feed.fetch_and_parse("http://search.twitter.com/search.atom?q=from%3A#{options[:from]}")
        twitter.entries.each do |t|
          tweet = Tweet.new
          tweet.from_user   = t.author
          tweet.text        = t.title
          tweet.created_at  = t.published
          list << tweet
        end
        
        list
      end

      def plugin_name
        :twitter
      end
    end
    
    class Tweet
      attr_accessor :from_user, :to_user, :text, :profile_image_url, :created_at
    end
  end
end

