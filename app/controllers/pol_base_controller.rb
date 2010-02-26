# all logic of the pol_controller is defined in this class, so it is easyly
# overwriteable by you own implementeation.
#
# the engine's pol_controller just extends this class, but adds no new logic.
class PolBaseController < ApplicationController
  include PolControl

  caches_page :show, :index, :replace_comp
  protect_from_forgery :except => :submit

  before_filter :set_locale
  before_filter :prepare_page, :except => :replace_comp
  skip_before_filter :authenticate

  def index
    render :action => :show
  end

  def show
  end

  # generic form submission action
  # this is called via xhr
  def submit
    model = Comp.find(params[:id])
    model.handle_submit(params)
    redirect_to '/'+model.page.permalink+'?success'
  end

  # this is called via the ls-R method. this is called by different tools
  # that need a directory style information about the entities on the server
  # (e.g. wget or tinymce image list).
  def sitemap
    # the use of the format parameter is a bit ugly, but for our current
    # requirements it suits
    respond_to do |format|
      # html responds with a sitemap suited for wget
      format.html do
        links = (Page.all.map(&:permalink) + [ 'index' ]).sort
        render :text => links.map { |l| "<a href='/#{l}'>#{l}</a>" }.join("\n")
      end
      # js responds with a javascript usable by tinymce
      format.js do
        imgs = CompImage.all.map do |c|
          "['#{c.media_file_name}', '#{c.media.url(:original)}']"
        end.join(',')
        render :text => "var tinyMCEImageList = new Array(#{imgs});"
      end
    end

  end

  # this is called via xhr
  def replace_comp
    @comp = Comp.find(params[:id])
  end

  protected

    def prepare_page
      @root = Page.root
      @page = Page.retrieve(params[:permalink])
      if @page.nil?
        render :text => File.read("#{Rails.root}/public/404.html"), :status => 404 and return
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


  Rails.logger.info('plugin pol_base_controller: completed class loading')
end
