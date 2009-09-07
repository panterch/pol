class PagesController < PolBackendController
  resource_controller

  index.wants.html { redirect_to edit_page_url(Page.root) }
  create.wants.html { redirect_to edit_page_url(object) }
  update.wants.html { redirect_to edit_page_url(object) }

  edit.before { globalize_object(object) }

  def order
    template = params["pages_#{object.id}"].reject { |id| id.blank? }
    object.order_children(template)
    render :update do |page|
      page.visual_effect :highlight, "pages_#{object.id}"
    end
  end

  protected

    def end_of_association_chain
      return Page.find(params[:page_id]).children if params[:page_id]
      return Page
    end

  private

end
