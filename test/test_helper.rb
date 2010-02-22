ENV["RAILS_ENV"] = "test"
TEST_FFMPEG = false unless defined?(TEST_FFMPEG)
require File.expand_path(File.dirname(__FILE__) + "/../config/environment")
require 'rails/test_help'

unless defined?(Factory)
  require  File.expand_path(File.dirname(__FILE__) + "/../vendor/plugins/factory_girl/lib/factory_girl.rb")
end
require File.dirname(__FILE__) + "/factories"

class ActiveSupport::TestCase
  # Setup all fixtures in test/fixtures/*.(yml|csv) for all tests in alphabetical order.
  #
  # Note: You'll currently still have to declare fixtures explicitly in integration tests
  # -- they do not yet inherit this setting
  fixtures :all

  # Add more helper methods to be used by all tests here...
  def assert_render(action, params = {})
    get action, params
    assert_response :success
    assert_template action.to_s
  end
end


Webrat.configure do |config|
  config.mode = :rails
end
