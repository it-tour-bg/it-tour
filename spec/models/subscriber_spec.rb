require 'spec_helper'

describe Subscriber do
  it "can returns its first error message" do
    subscriber = Subscriber.new
    subscriber.valid?
    expect(subscriber.error_message).to include 'Email'
  end

  it "can select only active subscribers" do
    active   = create :subscriber
    inactive = create :subscriber, active: false

    expect(Subscriber.active).to eq [active]
  end

  it "can select only subscriber from certain conference" do
    conference = create :conference
    subscribed = create :subscriber, conference: conference
    other      = create :subscriber, conference: create(:conference)

    expect(Subscriber.for_conference(conference.id)).to eq [subscribed]
  end

  describe "#conference_name" do
    it "returns conference name (if some)" do
      subscriber = build :subscriber, conference: build(:conference, name: 'VarnaConf')
      expect(subscriber.conference_name).to eq 'VarnaConf'
    end

    it "returns empty string if use isn't subscribed to any conference" do
      subscriber = Subscriber.new
      expect(subscriber.conference_name).to eq ''
    end
  end

  describe ".filter" do
    it "doesn't require any filters" do
      expect(Subscriber.filter).to eq Subscriber.all
    end

    it "can filter by conference_id" do
      allow(Subscriber).to receive(:for_conference).with(1) { 'filter by conference' }
      expect(Subscriber.filter(conference_id: 1)).to eq 'filter by conference'
    end

    it "can filter to only active subscribers" do
      allow(Subscriber).to receive(:active).and_return 'filter by active'
      expect(Subscriber.filter(active: true)).to eq 'filter by active'
    end
  end

  describe ".subscribe" do
    it "can create a new subscriber" do
      conference = create :conference
      subscriber = Subscriber.subscribe('mail@example.org', conference)

      expect(subscriber).to_not be_new_record
      expect(subscriber.email).to eq 'mail@example.org'
      expect(subscriber.conference).to eq conference
      expect(subscriber).to be_active
    end

    it "activates subscribe if he is inactive" do
      subscriber = Subscriber.subscribe create(:subscriber, active: false).email
      expect(subscriber).to be_active
    end

    it "can return invalid subscriber" do
      subscriber = Subscriber.subscribe 'invalid-email'
      expect(subscriber).to_not be_valid
    end
  end

  describe ".unsubscribe" do
    it "unsubscribe subscriber based on its token" do
      subscriber = create :subscriber
      Subscriber.unsubscribe(subscriber.token)
      expect { subscriber.reload }.to change(subscriber, :active?).to false
    end

    it "doesn't unsubscribe when token is not valid" do
      subscriber = create :subscriber
      Subscriber.unsubscribe('invalid-token')
      expect { subscriber.reload }.not_to change(subscriber, :active?)
    end

    it "can't be cheated by passing token with valid id" do
      subscriber = create :subscriber
      Subscriber.unsubscribe(EmailToken.for(double(email: 'fake@email.org', id: subscriber.id)))
      expect { subscriber.reload }.not_to change(subscriber, :active?)
    end
  end
end
