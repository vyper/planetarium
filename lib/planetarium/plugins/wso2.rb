module Planetarium
  module Plugin
    module WSO2
      class Base
        include Planetarium::Plugin::Base

        def products
          products = []
          
          value = Nokogiri::HTML.parse(Curl::Easy.perform("http://wso2.org").body_str)
          value.css("div#product-list div.content div div.hm-tabs").each do |product|
            p = Product.new
            p.url = "http://wso2.org/#{product.css('a[href*="library/"]').attr("href").to_s.gsub(/^\//, "")}"
            p.slug = product.css('a[href*="library/"]').attr("href").to_s.gsub(/^\/?library\//, "")
            products << p
          end
          
          products
        end

        def plugin_name
          :wso2
        end
      end
      
      class Product
        attr_accessor :url, :slug
        
        @@products = {
          'esb'                 => "WSO2 Enterprise Service Bus",
          'brs'                 => "WSO2 Business Rules Server",
          'governance-registry' => "WSO2 Governance Registry",
          'identity-server'     => "WSO2 Identity Server",
          'bam'                 => "WSO2 Business Activity Monitor",
          'gadget-server'       => "WSO2 Gadget Server",
          'bps'                 => "WSO2 Business Process Server",
          'mashup-server'       => "WSO2 Mashup Server",
          'dss'                 => "WSO2 Data Services Server",
          'application-server'  => "WSO2 Application Server",
          'carbon'              => "WSO2 Carbon",
          'wsf/php'             => "WSO2 Web Services Framework for PHP",
          'wsf/cpp'             => "WSO2 Web Services Framework for C++",
          'wsf/c'               => "WSO2 Web Services Framework for C"
        }
          
        def name
          @@products[@slug]
        end
      end
    end
  end
end