module TitleHelper
  def title(title)
    @_title = title
  end

  def title_value
    @_title
  end

  def title_with_base(base_title)
    [@_title, base_title].compact.join(' | ')
  end
end
