require 'spec_helper'

describe Photo do
  it { should belong_to :event }
  it { should validate_presence_of :asset }

  describe "#position" do
    it "is set to previous photo + 1 on creation" do
      event = create :event

      photo_1 = create :photo, event: event
      photo_2 = create :photo, event: event

      expect(photo_1.position).to eq 1
      expect(photo_2.position).to eq 2
    end

    it "is decreased when photo from event is removed" do
      event   = create :event
      photo_1 = create :photo, event: event, position: 1
      photo_2 = create :photo, event: event, position: 2
      photo_3 = create :photo, event: event, position: 3

      photo_2.destroy

      expect(photo_1.reload.position).to eq 1
      expect(photo_3.reload.position).to eq 2
    end

    it "doesn't care about photos from other events" do
      photo = create :photo
      other = create :photo

      expect(photo.position).to eq 1
      expect(other.position).to eq 1
    end

    it "can be overwritten" do
      photo = create :photo, position: 100
      expect(photo.position).to eq 100
    end
  end
end
