require File.dirname(__FILE__) + '/../test_helper'

class TestConfig < Test::Unit::TestCase
  def setup
    @file_path = "#{File.dirname(__FILE__)}/../tmp/config.yml" 
  end

  def test_load_by_hash
    c = Planetarium::Config.new({ 'name' => 'Planetarium', 'urls' => ['http://www.mcorp.com.br/feed/atom']})
    assert_equal c.name, 'Planetarium'
    assert_equal c.urls.count, 1
  end
  
  def test_load_by_file
    c = Planetarium::Config.new(@file_path)
    f = YAML::load_file(@file_path)
    
    assert_equal c.name, f['name']
    assert_equal c.urls.count, f['urls'].count
  end
  
  def test_name_is_required
    c = Planetarium::Config.new({})
    assert_raise RuntimeError do
      c.save
    end
  end
  
  def test_title_is_required
    c = Planetarium::Config.new({'name' => 'Planetarium'})
    assert_raise RuntimeError do
      c.save
    end
  end
  
  def test_url_is_required
    c = Planetarium::Config.new({'name' => 'Planetarium', 'title' => 'Planetarium'})
    assert_raise RuntimeError do
      c.save
    end
  end
  
  def test_template_is_required
    c = Planetarium::Config.new({'name' => 'Planetarium', 'title' => 'Planetarium', 
                                 'url' => 'http://planetarium.org/'})
    assert_raise RuntimeError do
      c.save
    end
  end
  
  def test_export_path_is_required
    c = Planetarium::Config.new({'name' => 'Planetarium', 'title' => 'Planetarium', 
                                 'url' => 'http://planetarium.org/', 'template' => 'basic'})
    assert_raise RuntimeError do
      c.save
    end
  end
  
  def test_urls_is_required
    c = Planetarium::Config.new({'name' => 'Planetarium', 'title' => 'Planetarium', 
                                 'url' => 'http://planetarium.org/', 'template' => 'basic',
                                 'export_path' => '/var/www/planetarium/'})
    assert_raise RuntimeError do
      c.save
    end
  end
  
  def test_urls_minimum
    c = Planetarium::Config.new({'name' => 'Planetarium', 'title' => 'Planetarium', 
                                 'url' => 'http://planetarium.org/', 'template' => 'basic',
                                 'export_path' => '/var/www/planetarium/', 'urls' => []})
    assert_raise RuntimeError do
      c.save
    end
  end

  def test_save
    File.delete @file_path if File.exists? @file_path

    c = Planetarium::Config.new(@file_path)
    c.name = 'Planetarium'
    c.title = 'Planetarium'
    c.url = 'http://planetarium.org/'
    c.export_path = '/var/www/planetarium/'
    c.template = 'basic'
    c.urls = ['http://www.mcorp.com.br/feed/atom']
    assert c.save
 
    n = YAML::load_file(@file_path)
    assert_equal c.name, n['name']
    assert_equal c.title, n['title']
    assert_equal c.urls.count, n['urls'].count
  end
end
