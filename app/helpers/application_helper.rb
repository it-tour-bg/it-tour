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

  def render_session(session)
    links = []
    links << link_to('видео', session.video_url, target: :blank) if session.video_url?
    links << link_to('слайдове', session.slides_url, target: :blank) if session.slides_url?

    session_info = session.title
    session_info << " - #{link_to session.speaker_name, '#speaker-' + session.speaker_id.to_s}" if session.speaker.present?
    session_info << " (#{links.join(', ')})" if links.present?
    session_info.html_safe
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
end
