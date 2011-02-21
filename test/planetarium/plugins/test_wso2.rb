require File.dirname(__FILE__) + '/../../test_helper'
require File.dirname(__FILE__) + '/../../../lib/planetarium/plugins/wso2'

class TestPluginWSO2 < Test::Unit::TestCase
  def test_products
    assert Planetarium::Plugin::WSO2::Base.new.products.is_a? Array
    products = Planetarium::Plugin::WSO2::Base.new.products
    assert products.first.is_a? Planetarium::Plugin::WSO2::Product
  end

  def test_names
    p = Planetarium::Plugin::WSO2::Product.new
    assert_equal p.name, nil
    p.slug = "esb"
    assert_equal p.name, "WSO2 Enterprise Service Bus"
  end

  def test_plugin_name
    assert_equal Planetarium::Plugin::WSO2::Base.new.plugin_name, :wso2
  end
end
