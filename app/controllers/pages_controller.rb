class PagesController < PolBackendController
  resource_controller

  create.wants.html { redirect_to edit_page_url(object) }
  update.wants.html { redirect_to edit_page_url(object) }

  def index
    redirect_to edit_object_url(Page.root)
  end

  def order
    template = params[object.id.to_s].reject { |id| id.blank? }
    object.order_children(template)
    render :update do |page|
      page.visual_effect :highlight, object.id.to_s
    end
  end

  protected

    def end_of_association_chain
      return Page.find(params[:page_id]).children if params[:page_id]
      return Page
    end

  private

end
