module Planetarium
  class Config
    attr_accessor :name, :title, :url, :template, :urls, :export_path
    
    def initialize(config)
      if config.instance_of? String
        File.new(config, "w") if !File.exists? config
        @file = config
        config = YAML::load_file(config) 
      elsif config.nil?
        @file = Planetarium::CONFIG_FILE
        config = YAML::load_file(@file) 
      end
     
      if config.instance_of? Hash
        @name         = config['name']
        @title        = config['title']
        @url          = config['url']
        @template     = config['template']
        @export_path  = config['export_path']
        @urls         = config['urls']
      end
    end
    
    def save
      raise 'Attribute "name" is required'        if @name.nil?
      raise 'Attribute "title" is required'       if @title.nil?
      raise 'Attribute "url" is required'         if @url.nil?
      raise 'Attribute "template" is required'    if @template.nil?
      raise 'Attribute "export_path" is required' if @export_path.nil?
      raise 'Attribute "urls" is required'        if @urls.nil?
      raise 'Minimum of attribute "urls" is 1'    if @urls.count == 0

      config = {
        'name'        => @name,
        'title'       => @title,
        'url'         => @url,
        'template'    => @template,
        'export_path' => @export_path,
        'urls'        => @urls
      }

      File.open(@file, "w+") do |f|
        f << YAML::dump(config)
      end
    end
  end
end
