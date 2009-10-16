class CompYaml < Comp

  # component used to serialize data in content
  # only for internal use
  serialize :content

  def visible?
    false
  end

  def pageable?
    false
  end

  def cacheable?
    false
  end


end
