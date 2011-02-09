module Planetarium
  module Command
    def self.update
      config  = Planetarium::Base.config
      name    = config['name']
      urls    = config['urls']
      version = Planetarium::VERSION

      feeds = Feedzirra::Feed.fetch_and_parse(config['urls']).each_value

      File.open("../#{config["path"]}/index.html", "w") do |out|
        t = ERB.new(File.read("../templates/#{config['template']}/index.html.erb"), 0, "%<>")
        out.puts t.result(binding)
      end
    end
  end
end
