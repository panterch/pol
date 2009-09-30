class Page < ActiveRecord::Base

  if pol_cfg.multilang?
    translates :title, :desc
    accepts_nested_attributes_for :globalize_translations
  end

  acts_as_tree :order => :position
  acts_as_list :scope => :parent_id

  has_many :comps, :dependent => :destroy
  
  # the '#' in the geometry is an improvment by paperclip which will
  # create square thumbnails that are nicely cropped.
  has_attached_file :icon, :styles => { :normal => "75x75#" },
                    :default_style => :normal
  has_permalink [:ancestor_titles, :title]


  def order_children(ids)
    ids.reverse.each do |c|
      c = Page.find(:first, :conditions => { :parent_id => self.id, :id => c })
      c.move_to_top
    end
    self.children(true)
  end

  # children that are suited for navigation ("not hidden")
  def nav_children
    self.children.reject{ |c| c.hidden }
  end

  # children for paging navigation
  def subpages
    self.children.select{ |c| c.hidden }
  end

  def ancestor_titles
    self.ancestors[0...-1].map(&:title).join('-')
  end

  def ancestors_and_self
    ancestors.reverse + [self]
  end

  def comps_styled(style)
    comps.find(:all, :order => :position).select do |comp|
      comp.style_class == style && comp.visible?
    end
  end

  def comps_left
    comps_styled('left-box')
  end

  def comps_right
    comps_styled('right-box')
  end

  def comps_top
    comps_styled('top-box')
  end

  def comps_bottom
    comps_styled('bottom-box')
  end
  
  def comp_map
    comps.find(:first, :order => :position, :conditions => 
               { :type => 'CompMap' } )
  end
  
  def comp_gallery
    comps.find(:first, :order => :position, :conditions => 
                { :type => 'CompGallery' } )
  end

protected


end
