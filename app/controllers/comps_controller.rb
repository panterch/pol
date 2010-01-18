class CompsController < PolBackendController

  before_filter :load_page, :except => [:index]
  before_filter :load_comp, :except => [:index, :new, :create]
  before_filter :load_parent
  
  protect_from_forgery :only => [:create, :destroy]

  def new
    @comp = Comp.build_sti(type_param, :page => @page)
    @comp.style_class = params[:style_class] || @parent.try(:style_class)
    globalize_object(@comp)
  end
  
  def create
    @comp = Comp.build_sti(type_param, params[:comp])
    if (@comp.valid?)
      @comp.parent = @parent
      @page.comps << @comp
      flash[:notice] = t('flash.comp.created') 
      redirect_to edit_page_url(@comp.page)
    else
      render :action => :new
    end
  end
  
  def edit
  end
  
  def update
    if (@comp.update_attributes(params[:comp]))
      flash[:notice] = t('flash.comp.updated') 
      redirect_to edit_page_url(@comp.page)
    else
      render :action => :edit
    end
  end 

  def destroy
    @comp.destroy
    flash[:notice] = t('flash.comp.destroyed') 
    redirect_to edit_page_url(@comp.page)
  end

  def down
    @comp.move_lower
    redirect_to edit_page_url(@comp.page)
  end

  def up
    @comp.move_higher
    redirect_to edit_page_url(@comp.page)
  end
    
  protected
  
    def load_page
      @page = Page.find(params[:page_id])
    end
    
    def load_comp
      @comp = Comp.find(params[:id])
    end  
    
    def load_parent
      @parent = Comp.find(params[:comp_id]) if params[:comp_id]
    end

    # this controller can handle various subclasses of component. the type of
    # the actual wanted class is submitted by different means. this method tries
    # to extract the wanted type from the request
    def type_param
      params[:type] || # as plain paramter
      (params[:comp] && params[:comp][:type]) || # as hidden field on comp form
      request.path.match('^/pages/\d+/(\w*).*$')[1].classify # from routes.rb
    end
    
end
