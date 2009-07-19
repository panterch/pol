require 'test_helper'

class ContactTest < ActiveSupport::TestCase

  def setup
    ActionMailer::Base.deliveries.clear
  end

  def test_deliver
    Factory(:contact)
    assert_equal 1, ActionMailer::Base.deliveries.length
  end
  

end
