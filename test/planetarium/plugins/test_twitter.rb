require File.dirname(__FILE__) + '/../../test_helper'
require File.dirname(__FILE__) + '/../../../lib/planetarium/plugins/twitter'

class TestPluginTwitter < Test::Unit::TestCase
  def setup
    @t = Planetarium::Plugin::Twitter.new
  end

  def test_plugin_name
    assert_equal @t.plugin_name, :twitter
  end
  
  def test_search_return_is_array
    assert @t.search({}).is_a? Array
  end
end
