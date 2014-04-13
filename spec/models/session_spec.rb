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
end
