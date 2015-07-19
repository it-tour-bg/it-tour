require 'spec_helper'

describe Session do
  describe "(default scope)" do
    it "orders session by start at" do
      at_12_30 = create :session, start_at: '12:30'
      at_15_10 = create :session, start_at: '15:10'
      at_14_20 = create :session, start_at: '14:20'

      expect(Session.all).to eq [at_12_30, at_14_20, at_15_10]
    end
  end

  describe '.announced' do
    it 'includes only announced sessions' do
      unannounced = create :session, event: create(:event, sessions_announced: false)
      announced   = create :session, event: create(:event, sessions_announced: true)

      expect(Session.announced).to eq [announced]
    end
  end

  describe '.by_track' do
    it 'groups by track number' do
      track_1 = create :session, track: 1
      track_2 = create :session, track: 2

      expect(Session.by_track).to eq 1 => [track_1], 2 => [track_2]
    end
  end
end
