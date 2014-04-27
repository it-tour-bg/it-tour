#encoding: utf-8
module ApplicationHelper
  def actions(&block)
    content_for :actions, &block
  end

  def markdown(text)
    RenderMarkdown.to_html(text).html_safe
  end

  def copyright
    "© #{Date.today.year} IT Tour."
  end

  def back_link
    content_tag :article, link_to("Обратно към #{current_conference.name}", root_url)
  end

  def new_line_to_break(text)
    return '' if text.blank?
    text = h(text)
    raw text.gsub(/[\r]*[\n]/, '<br>').strip
  end

  def render_in_layout(&block)
    content_for :content, &block
    render template: 'layouts/application'
  end

  def current_event
    @current_event ||= @event || EventDecorator.decorate(current_conference.current_event)
  end

  def with_event(event)
    yield EventDecorator.decorate(event)
  end

  def conference_url(conference)
    "http://#{conference.domain}"
  end

  def current_event_path(options = {})
    event_path current_event, options
  end

  def event_path(event, options = {})
    if event.current?
      root_path options
    else
      archive_path event.name, options
    end
  end
end
