#encoding: utf-8
module ApplicationHelper
  def actions(&block)
    content_for :actions, &block
  end

  def markdown(text)
    RenderMarkdown.to_html(text).html_safe
  end

  def copywrite
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
end
