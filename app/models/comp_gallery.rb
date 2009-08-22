class CompGallery < Comp

  # this control comes alway as a pair. which role an instance plays is
  # configured by comp_gallery_control_style and comp_gallery_view_style
  
  before_create :create_view_child, :if => :"is_control?"

  def allowed_children_comps
    return [] unless is_control?
    return %w( CompImage )
  end

  def is_control?
    pol_cfg.comp_gallery_control_style == style_class
  end

  def is_view?
    pol_cfg.comp_gallery_view_style == style_class
  end

  def visible?
    true
  end

  def destroyable?
    is_control?
  end

  def editable?
    is_control?
  end



protected 

  # create a marker component on the page part where the gallery view should
  # be rendered
  def create_view_child
    children << CompGallery.new(:page => self.page,
                                :style_class => pol_cfg.comp_gallery_view_style)
  end

  
end
