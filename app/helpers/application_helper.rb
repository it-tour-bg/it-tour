module ApplicationHelper
  def actions(&block)
    content_for :actions, &block
  end

  def markdown(text)
    RenderMarkdown.to_html(text).html_safe
  end
end
