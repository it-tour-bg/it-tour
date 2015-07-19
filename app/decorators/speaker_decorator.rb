class SpeakerDecorator < Draper::Decorator
  decorates :speaker
  delegate_all

  SOCIAL_LINKS = {
    twitter_account:  ['twitter', 'http://twitter.com/%s'],
    github_account:   ['github', 'http://github.com/%s'],
    facebook_account: ['facebook', 'http://facebook.com/%s'],
    company_site:     ['company', '%s'],
    dribbble_account: ['dribbble', 'http://dribbble.com/%s'],
  }

  def social_links
    SOCIAL_LINKS.map do |key, (type, mask)|
      link = object.public_send key
      [type, mask % link] if link.present?
    end.compact
  end

  def ordered_sessions
    sessions.announced.reorder 'id ASC'
  end
end
