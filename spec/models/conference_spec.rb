require 'spec_helper'

describe Conference do
  it { should validate_presence_of :name }
  it { should validate_presence_of :contact_name }
  it { should validate_presence_of :contact_email }
  it { should have_many :events }


  describe ".find_for_domain" do
    it "finds conference by domain" do
      varna = create :conference, domain: 'varnaconf.com'
      sofia = create :conference, domain: 'sofiaconf.com'

      expect(Conference.find_for_domain('varnaconf.com')).to eq varna
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
  end

  describe "#finished_event_named" do
    it "finds event by given name" do
      conference = create :conference

      event = create :finished_event, conference: conference
      other = create :finished_event, conference: conference

      expect(conference.finished_event_named(event.name)).to eq event
    end

    it "finds only finished events" do
      conference = create :conference
      event = create :current_event, conference: conference
      expect { conference.finished_event_named(event.name) }.to raise_error ActiveRecord::RecordNotFound
    end
  end

  describe "#finished_events" do
    it "lists all finished events" do
      conference = create :conference

      future    = create :future_event, conference: conference
      current   = create :current_event, conference: conference
      finished1 = create :finished_event, conference: conference, name: '2012'
      finished2 = create :finished_event, conference: conference, name: '2013'

      expect(conference.finished_events).to eq [finished1, finished2]
    end
  end
end
