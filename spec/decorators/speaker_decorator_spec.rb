require 'spec_helper'

describe SpeakerDecorator do
  describe "#social_links" do
    def social_links_of(speaker)
      SpeakerDecorator.new(speaker).social_links
    end

    it "can have twitter" do
      speaker = Speaker.new twitter_account: 'user'
      expect(social_links_of(speaker)).to eq [['twitter', 'http://twitter.com/user']]
    end

    it "can have company site" do
      speaker = Speaker.new company_site: 'http://example.com'
      expect(social_links_of(speaker)).to eq [['company', 'http://example.com']]
    end

    it "can have github account" do
      speaker = Speaker.new github_account: 'user'
      expect(social_links_of(speaker)).to eq [['github', 'http://github.com/user']]
    end

    it "can have facebook account" do
      speaker = Speaker.new facebook_account: 'user'
      expect(social_links_of(speaker)).to eq [['facebook', 'http://facebook.com/user']]
    end

    it "can have dribbble account" do
      speaker = Speaker.new dribbble_account: 'user'
      expect(social_links_of(speaker)).to eq [['dribbble', 'http://dribble.com/user']]
    end
  end
end
