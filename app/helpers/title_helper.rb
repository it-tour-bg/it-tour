module TitleHelper
  def title(title, counter = nil)
    @_title = title
    @_title_counter = counter
  end

  def title_value
    @_title
  end

  def title_header
    "#{@_title}#{' (' + @_title_counter.to_s + ')' if @_title_counter.present?}"
  end

  def title_with_base(base_title)
    [@_title, base_title].compact.join(' | ')
  end
end
