require 'spec_helper'

describe SpeakerDecorator do
  describe "#social_links" do
    it "has twitter" do
      speaker = Speaker.new twitter_account: 'user'

      expect(SpeakerDecorator.new(speaker).social_links).to eq [['twitter', 'http://twitter.com/user']]
    end

    it "has company site" do
      speaker = Speaker.new company_site: 'http://example.com'

      expect(SpeakerDecorator.new(speaker).social_links).to eq [['company', 'http://example.com']]
    end
  end
end
