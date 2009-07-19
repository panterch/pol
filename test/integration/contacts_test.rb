require 'test_helper'

class ContactsTest < ActionController::IntegrationTest
  
  def setup
    Factory(:page)
  end
  
  test "render contact views" do
    visit new_contact_path
    fill_in 'contact[from]', :with => 'Seeliger'
    fill_in 'contact[body]', :with => 'Beat'
    assert_difference 'Contact.count' do
      click_button
    end
  end
  
end
