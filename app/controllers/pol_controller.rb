class PolController < ApplicationController
  include PolControl

  layout 'pol'
  caches_page :show, :index, :replace_comp

  before_filter :set_locale
  before_filter :prepare_page, :except => :replace_comp
  skip_before_filter :authenticate

  def index
    render :action => :show
  end

  def show
  end

  # this is called by wget
  def sitemap
    links = (Page.all.map(&:permalink) + [ 'index' ]).sort
    render :text => links.map { |l| "<a href='/#{l}'>#{l}</a>" }.join("\n")
  end

  # this is called via xhr
  def replace_comp
    @comp = Comp.find(params[:id])
  end

  protected

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
