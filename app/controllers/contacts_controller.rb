class ContactsController < ApplicationController
  helper :pol

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

  # TODO: this code is duploicated in PolController!!!
  def prepare_page
    @root = Page.root
    @page = params[:permalink] ? Page.find_by_permalink(params[:permalink]) :
                                 @root
    if @page.nil?
      render :file => "#{RAILS_ROOT}/public/404.html", :status => 404 and return 
    end

    # build the navigation
    # since hidden pages do not really alter the navigations tree, their
    # parent is used to build the navigation
    @ancs = (@page.hidden ? @page.parent : @page).ancestors_and_self
    @subnav = @ancs[1].nav_children if @ancs.length > 1
    @relnav = @ancs[2].nav_children if @ancs.length > 2
    @icon_nav = @ancs[3].nav_children if @ancs.length > 3
    unless @ancs.last.subpages.blank?
      @subpage_nav = [ @ancs.last ] + @ancs.last.subpages
    end
  end
  
  
end
