require 'spec_helper'

describe Event do
  it "has full name" do
    event = Event.new name: '2013', conference: Conference.new(name: 'VarnaConf')
    expect(event.full_name).to eq 'VarnaConf 2013'
  end

  describe "#current" do
    it "requires event to be publicly announced" do
      event = build :event, publicly_announced: false, current: true
      expect(event).to_not be_valid
    end

    it "is only one per conference" do
      conference = create :conference

      event1 = create :current_event, conference: conference
      event2 = create :current_event, conference: conference

      expect(event1.reload).to_not be_current
      expect(event2.reload).to be_current
    end

    it "doesn't care about current events in other conferences" do
      event1 = create :current_event
      event2 = create :current_event

      expect(event1.reload).to be_current
      expect(event2.reload).to be_current
    end
  end
end
