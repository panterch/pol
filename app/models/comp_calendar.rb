class CompCalendar < Comp

  def pageable?
    false
  end

  def cacheable?
    true
  end
end
