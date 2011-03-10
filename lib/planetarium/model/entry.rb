module Planetarium
  module Model
    class Entry
      attr_accessor :id, :title, :author, :published, :content, :url, :updated,
                    :summary, :feed

      def initialize id, title, author, published, content, url, updated, summary, feed
        @id = id
        @title = title
        @author = author
        @published = published
        @content = content
        @url = url
        @updated = updated
        @summary = summary
        @feed = feed
      end
    end
  end
end
