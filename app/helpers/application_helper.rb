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


  SOCIAL_LINK_CLASSES = {
    github:   ['https://github/%s', 'icon-github'],
    twitter:  ['http://twitter.com/%s', 'icon-twitter'],
    facebook: ['http://facebook.com/%s', 'icon-facebook-squared'],
  }

  def social_link(social_network, account_name)
    if account_name.present?
      site_address, icon_class = SOCIAL_LINK_CLASSES[social_network]
      icon = %Q(<i class="#{icon_class}"></i>).html_safe
      link_to icon, site_address % account_name, class: 'icon'
    end
  end
end
