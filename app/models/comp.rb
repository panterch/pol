class Comp < ActiveRecord::Base

  if pol_cfg.multilang?
    translates :content
    accepts_nested_attributes_for :globalize_translations
  end
  
  acts_as_tree :order => :position
  # scope visbile components to page and style (they are displayed in their
  # order on the page) and invisible components additionally to their parent
  # (the parent is rendered and the children are rendered whitin, in their own
  # order)
  acts_as_list :scope => 'page_id = #{page_id} '+
     'AND style_class = \'#{style_class}\' '+
     'AND parent_id #{visible? ? \'IS NULL\' : \'= \'+parent_id.to_s}'

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

  # returns the comp_name without comp_
  def kind
    type.to_s.underscore[5..-1]
  end

  # when set to true will cause the sweeper to act
  def cacheable?
    true
  end
  
end
