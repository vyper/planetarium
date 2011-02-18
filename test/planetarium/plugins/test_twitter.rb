require File.dirname(__FILE__) + '/../../test_helper'
require File.dirname(__FILE__) + '/../../../lib/planetarium/plugins/twitter'

class TestPluginTwitter < Test::Unit::TestCase
  def setup
    @t = Planetarium::Plugin::Twitter.new
  end

  def test_plugin_name
    assert_equal @t.plugin_name, :twitter
  end
  
  def test_search_return
    assert @t.search({ :from => "wso2brasil" }).is_a? Array
  end
end
