class Comp < ActiveRecord::Base
  
  acts_as_tree :order => :position
  acts_as_list :scope => 'page_id = #{page_id} '+
     'AND style_class = \'#{style_class}\' '+
     'AND parent_id #{parent_id.nil? ? \'IS NULL\' : \'= \'+parent_id.to_s}'

  belongs_to :page

  def self.build_sti(type, attrs = {})
    clazz = Kernel.const_get(type)
    raise SecurityError unless Comp == clazz.superclass
    clazz.new(attrs)
  end

  # should there be rendered controls for subcomponents?
  def allowed_children_comps
    []
  end

  # component supports paging
  def pageable?
    false
  end

  # this determines if the component should be rendered or not. normally only
  # the parent components get rendered directly, children are rendered by their
  # parents.
  def visible?
    parent.nil?
  end

  def destroyable?
    true
  end

  def editable?
    true
  end

  def moveable?
    true
  end
  
end
