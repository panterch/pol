class ContactsController < ApplicationController

  resource_controller
  layout 'pol'

  skip_before_filter :authenticate
  before_filter :prepare_page
  before_filter :adapt_page
  
protected

  # fakes a contact page
  def adapt_page
    
    @page.title = 'Kontakt'
    @page.desc = 'Kontakt'
  end
  
  
end
