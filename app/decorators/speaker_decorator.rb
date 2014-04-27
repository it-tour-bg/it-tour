class SpeakerDecorator < Draper::Decorator
  decorates :speaker
  delegate_all

  SOCIAL_LINKS = {
    twitter_account:  ['twitter', 'http://twitter.com/%s'],
    company_site:     ['company', '%s'],
  }

  def social_links
    SOCIAL_LINKS.map do |key, (type, mask)|
      link = object.public_send key
      [type, mask % link] if link.present?
    end.compact
  end
end
