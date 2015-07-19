require 'spec_helper'

describe SpeakerDecorator do
  describe "#social_links" do
    def social_links_of(speaker)
      described_class.new(speaker).social_links
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
      expect(social_links_of(speaker)).to eq [['dribbble', 'http://dribbble.com/user']]
    end
  end

  describe '#ordered_sessions' do
    def ordered_sessions_of(speaker)
      described_class.new(speaker).ordered_sessions
    end

    it 'includes only announced sessions' do
      speaker = create :speaker

      other       = create :session
      unannounced = create :session, speakers: [speaker], event: create(:event, sessions_announced: false)
      announced   = create :session, speakers: [speaker], event: create(:event, sessions_announced: true)

      expect(ordered_sessions_of(speaker)).to eq [announced]
    end
  end
end
