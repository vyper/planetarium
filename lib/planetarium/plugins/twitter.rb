module Planetarium
  module Plugin
    class Twitter
      include Planetarium::Plugin::Base

      def search(options)
        list = []

        er_url     = /(http:\/\/([a-zA-Z.\/0-9]+))/
        er_hashtag = /#([a-zA-Z0-9]+)/
        er_user    = /@([a-zA-Z0-9_]+)/
        
        twitter = Feedzirra::Feed.fetch_and_parse("http://search.twitter.com/search.atom?q=from%3A#{options[:from]}")
        twitter.entries.each do |t|
          tweet = Tweet.new
          tweet.from_user   = t.author
          tweet.text        = t.title
          tweet.text        = tweet.text.gsub(er_url,     '<a href="\1" target="_blank">\2</a>')
          tweet.text        = tweet.text.gsub(er_hashtag, '<a href="http://twitter.com/search?q=%23\1">#\1</a>')
          tweet.text        = tweet.text.gsub(er_user,    '<a href="http://twitter.com/\1">@\1</a>')
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

