module PolHelper

  def page_link(page)
    permalink page.title, page, :class => page.style_class
  end

  def activated(p)
    return 'active' if @page == p
    @page.ancestors.include?(p) ? 'active' : ""
  end

  # renders a flat menu of the given pages
  def menu_items(pages)
    pages.map{ |p| content_tag(:li, page_link(p), :class => activated(p))}.join("\n")
  end

  # renders a menu using the page icons given
  def menu_icons(pages)
    pages.map do |p|
      content_tag :li, permalink(image_tag(p.icon.url),p,:class =>activated(p))
    end.join("\n")
  end

  # renders a flat menu but assures that the current @page is visible in the
  # menu including its children / siblings
  #
  # currently this supports only two navigation levels
  def tree_menu(pages)
    content_tag :ul do
      pages.map do |p|
        content_tag(:li, :class => activated(p)) do
          content = page_link(p)
          if @page.ancestors_and_self.include?(p)
            content += tree_menu(p.children) unless p.children.empty?
          end
          content
        end
      end
    end
  end

  def language_items(chars = 1)
    pol_cfg.languages.map do |l|
      active = (I18n.locale == l) ? 'active' : ''
      content_tag(:li, permalink(l.upcase[0...chars], @page, :locale => l), :class => active)
    end.join("\n")
  end

  def render_subpage_nav(pages)
    content = ''

    cur_i = pages.index(@page)

    pages.each_with_index do |page, index|
      content += content_tag :span do
        (cur_i != index) ? permalink(page.desc, page) : (page.desc)
      end
    end

    content_tag :div, content, :class => 'pager'
  end

  def body_style
    return "trans" if @ancs.length < 3
    @page.ancestors_and_self[2].style_class
  end

  def permalink(title, page, params = {})
    link_to title, href(page, params), params
  end

  def href(page, params = {})
    locale = params.delete(:locale)
    locale ||= pol_cfg.multilang? ? "#{I18n.locale}" : nil
    link = (page.is_a? Page) ? page.permalink : page.to_s
    link = [ locale, link ].compact.join('/')
    "/#{link}"
  end

  def javascript(*files)
    content_for(:head) { javascript_include_tag(*files) }
  end

  def javascript_url(url)
    content_for :head, "<script type='text/javascript' src='#{url}'></script>\n"
  end

  def forward
    "weiter "+"&gt;"*3
  end

  def back
    "&lt;"*3+" zur&uuml;ck"
  end


  def render_form_partial(form)
    render :partial =>
      '/comps/form'+form.object.attributes['type'].to_s.underscore[4..-1],
      :object => form
  end

  def render_show_partial(comp)
    kind = comp.kind
    main = comp.parent || comp
    content = ''

    # render control icons when in backend
    if require_controls?
      content += render_controls(comp)
    end

    # render component
    content += render :partial => '/comps/'+kind, :object => comp

    # render pager
    if main.pageable? && !main.children.blank?
      content += render :partial => '/comps/pager', :object => comp
    end

    # render div holding everything above (hidden when a child)
    content = content_tag :div, content,
      :id => "comp_#{comp.id}", :class => "comp comp_#{kind}",
      :style => comp.parent.try(:pageable?) ? "display: none;" : ''

    # render children recursive
    comp.children.each do |child|
      next unless comp.pageable?
      content += render_show_partial(child)
    end

    content
  end


  def require_controls?
    return controller.is_a? PagesController
  end

  def render_controls(comp)
    # for subcomponent some actions match on the component himself (like
    # delete) and some are more suitable for its parent (like move).
    main = comp.parent || comp
    content  = ''
    if (comp.editable?)
      content  = link_to '', edit_page_comp_path(comp.page.id, comp),
        :class => 'policon edit', :title => 'Bearbeiten'
    end
    if (comp.destroyable?)
      content += link_to '', page_comp_path(comp.page.id, comp),
        :confirm => "Are you sure?", :method => :delete,
        :class => 'policon delete', :title => 'Loeschen'
    end
    if (comp.moveable?)
      content += link_to '', up_page_comp_path(main.page.id, main),
        :method => :put, :class => 'policon up',
        :title => 'Nach oben verschieben'
      content += link_to '', down_page_comp_path(main.page.id, main),
        :method => :put, :class => 'policon down',
        :title => 'Nach unten verschieben'
    end

    comp.allowed_children_comps.each do |comp_type|
      content += link_to '',
        new_page_comp_comp_path(comp.page.id, comp, :type => comp_type),
        :class => 'policon '+comp_type
    end

    content += content_tag :span do
      "#{comp.class.human_name} / #{I18n.t(comp.style_class, :scope => :pol)}"
    end

    return content_tag :div, content, :class => 'comp_control clearfix'
  end

  def render_gallery_controls(gallery_comp, image_comp)
    content = link_to '', up_page_comp_path(gallery_comp.page.id, image_comp),
      :method => :put, :class => 'policon up',
      :title => 'Nach oben verschieben'
    content += link_to '', down_page_comp_path(gallery_comp.page.id, image_comp),
      :method => :put, :class => 'policon down',
      :title => 'Nach unten verschieben'
    content += link_to '', edit_page_comp_path(gallery_comp.page.id, image_comp),
      :class => 'policon edit', :title => 'Bearbeiten'
    content += link_to '', page_comp_path(gallery_comp.page.id, image_comp),
      :confirm => "Are you sure?", :method => :delete,
      :class => 'policon delete', :title => 'Loeschen'
  end

  def render_map_controls(comp)
    content = link_to '', new_page_comp_comp_path(comp.page.id, comp,
    :type => 'CompText', :style_class => 'left-box'),
      :class => 'policon texticon', :title => 'Text',
      :onclick => 'return granat.maps.editSubComp(this);'
    content += link_to '', new_page_comp_comp_path(comp.page.id, comp,
    :type => 'CompImage', :style_class => 'left-box'),
      :class => 'policon image', :title => 'Bild',
      :onclick => 'return granat.maps.editSubComp(this);'
    content += link_to '', new_page_comp_comp_path(comp.page.id, comp,
    :type => 'CompVideo', :style_class => 'left-box'),
      :class => 'policon video', :title => 'Video',
      :onclick => 'return granat.maps.editSubComp(this);'
    content += link_to '', new_page_comp_comp_path(comp.page.id, comp,
    :type => 'CompRaw', :style_class => 'left-box'),
      :class => 'policon html', :title => 'HTML',
      :onclick => 'return granat.maps.editSubComp(this);'

    return content_tag :p, content,
      :style => 'padding-left: 40px; text-align: center;'
  end


  def collect_map_children(page)
    map_children = []
    return map_children if page.children.length == 0
    page.children.each do |cp|
      map_children += cp.comp_map.children unless cp.comp_map.nil?
      map_children += collect_map_children(cp) unless cp.children.length == 0
    end
    map_children
  end

  def id_for(comp)
    "comp_container_#{comp.id}"
  end


  # renders an ul / li tree of all pages
  def render_page_tree(pages = Page.roots, parent = nil)
    content_tag :ul, { :id => tree_page_id(parent) } do
      pages.map do |page|
        content_tag :li, render_page_tree_li(page), {:id => tree_page_id(page), :class => ('active' if page == @page)}
      end.join("\n")
    end
  end

  def tree_page_id(page)
    ['tree', 'page', page.try(:id)].compact.join('_')
  end

  def render_page_tree_li(page)
    content = link_to(page.title, edit_page_path(page))
    content << render_page_tree(page.children, page) if page.children.any?
    content
  end

  def render_path(page, anchestors = [])
    anchestors << page.title
    return anchestors.reverse.join(' - ') if page.parent.nil?
    return render_path(page.parent, anchestors)
  end

  # renders the backend navigation
  def render_nav(page)
    content = ''
    level = 0
    # 1. render ancestors
    page.ancestors.reverse.each do |a|
      content << render(:partial => 'pages/nav',
                        :locals => { :parent => a.parent,
                                     :pages => a.self_and_siblings,
                                     :active => a,
                                     :level => level += 1 })
    end
    # 2. render sibling
    content << render(:partial => 'pages/nav',
                      :locals => { :parent => page.parent,
                                   :pages => page.self_and_siblings,
                                   :active => page,
                                   :level => level += 1 })
    # 4. render children for existin records
    return content if page.new_record?
    return content if level >= pol_cfg.max_nav_level
    # do not display children nav for roots that are not the first root
    # to avoid this, explicitly add a child (via migration)
    # This allows sites on top level without children (typically 'contact',
    # 'disclaimer' ... )
    return content if level == 1 && Page.root != page && page.children.empty?
    content << render(:partial => 'pages/nav',
                      :locals => { :parent => page,
                                   :pages => page.children,
                                   :active => nil,
                                   :level => level += 1 })
  end

  def render_subcomps_all(comp)
    render_subcomps(comp, "comps/subcomp")
  end

  def render_subcomps_pos(comp)
    render_subcomps(comp, "comps/subcomp_pos")
  end

  def render_subcomps(comp, partial)
    content = ''
    subcomps = comp.children
    if(subcomps.nil?)
      content
    end
    reg_cids = Array.new
    subcomps.each do |sc|
      content << render(:partial => partial,
                        :locals => { :comp => sc, :render_levels => true })
      reg_cids.push(sc.id) unless (sc.lat.nil? || sc.lng.nil?)
    end
    reg_cids_value = reg_cids.join(',')
    content << hidden_field_tag("markers_register",reg_cids_value,
                                {:id => 'markers.register'})

    content
  end

  def render_subcomps_reg(comps)
    content = ''
    return '' if comps.nil? || comps.length == 0
    reg_cids = Array.new
    comps.each do |sc|
      reg_cids.push(sc.id) unless (sc.lat.nil? || sc.lng.nil?)
    end
    reg_cids_value = reg_cids.join(',')
    content << hidden_field_tag("markers_register",reg_cids_value,
                                {:id => 'markers.register'})
    content
  end

  def render_map_children(page)
    child_comps = page.comp_map.children
    render_levels = false
    if child_comps.length == 0
      child_comps = collect_map_children(page)
      render_levels = true
    end
    content = ''
    child_comps.each_with_index do |mc, i|
      # render component (with controls) when in backend
      if controller.is_a? PagesController || i < 10
        content += render :partial => 'comps/subcomp', :locals => { :comp => mc }
      end
      content += render :partial => 'comps/subcomp_pos', :locals =>
        { :comp => mc, :render_levels => render_levels }
    end
    content += render_subcomps_reg(child_comps)
  end


  def parent_pages(current_page, pages = Page.roots, depth = 1)
    pages.inject([]) do |list, page|
      list << [page.title, page.id] unless page == current_page
      list += parent_pages(current_page, page.children, depth + 1) if depth < (pol_cfg.max_nav_level - 1) && pages.exclude?(current_page)
      list
    end
  end

  def dynamic_field(form, attribute, values)
    field = form.label(attribute, values[:name] || attribute.to_s)
    case values[:class]
      when 'String'
        field << form.text_field(attribute)
      when 'Array'
        field << form.collection_select(attribute, values[:collection], :to_s, :to_s)
    end
    field
  end
end
