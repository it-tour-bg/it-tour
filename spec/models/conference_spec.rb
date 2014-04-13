require 'spec_helper'

describe Conference do
  describe "main conference" do
    it "has only one main conference" do
      first  = create :conference, main: true
      second = create :conference, main: true

      expect(second.reload).to be_main
      expect(first.reload).not_to be_main
    end
  end

  describe ".regular" do
    it "selects all confrences except the main one" do
      main  = create :conference, main: true
      other = create :conference, main: false

      expect(Conference.regular).to eq [other]
    end
  end

  describe ".find_for_domain" do
    it "finds conference by domain" do
      varna = create :conference, domain: 'varnaconf.com'
      sofia = create :conference, domain: 'sofiaconf.com'

      expect(Conference.find_for_domain('varnaconf.com')).to eq varna
    end
  end

  describe ".with_events" do
    it "selects only conferences with ongoing events" do
      with_announced_event = create(:event, publicly_announced: true).conference
      with_hidden_event    = create(:event, publicly_announced: false).conference
      without_event        = create(:conference)

      expect(Conference.with_events).to eq [with_announced_event]
    end
  end

  describe "#current_event" do
    it "finds current conference event" do
      conference = create :conference

      future   = create :future_event, conference: conference
      current  = create :current_event, conference: conference
      finished = create :finished_event, conference: conference

      expect(conference.current_event).to eq current
    end

    it "fallbacks to previous events there isn't a current event" do
      conference = create :conference

      future   = create :future_event, conference: conference
      finished = create :finished_event, conference: conference

      expect(conference.current_event).to eq finished
    end
  end

  describe "#regular?" do
    it "is revert of main?" do
      expect(Conference.new(main: true)).not_to be_regular
      expect(Conference.new(main: false)).to be_regular
    end
  end

  describe "#announced_event_named" do
    it "finds event by given name" do
      conference = create :conference

      event = create :event, conference: conference
      other = create :event, conference: conference

      expect(conference.announced_event_named(event.name)).to eq event
    end

    it "finds only publicly announced events" do
      conference = create :conference

      event = create :event, conference: conference, publicly_announced: false

      expect { conference.announced_event_named(event.name) }.to raise_error ActiveRecord::RecordNotFound
    end
  end
end
