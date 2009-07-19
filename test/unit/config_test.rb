require 'test_helper'

class ConfigTest < ActiveSupport::TestCase

  def test_singleton
    assert_same PolConfig.instance, PolConfig.instance
  end

  def test_version
    assert !PolConfig.instance.version.blank?
  end

  def test_overwrite
    PolConfig.instance.version = 'test'
    assert_equal 'test', PolConfig.instance.version
  end

  def test_shortcut
    assert_same pol_cfg, PolConfig.instance
  end
    
end

