require 'spec_helper'

describe Photo do
  it { should belong_to :event }
  it { should validate_presence_of :asset }

  describe "#change_position_of" do
    it "reorders photos in the given order" do
      photo_1 = create :photo
      photo_2 = create :photo
      photo_3 = create :photo

      ids = [photo_2, photo_3, photo_1].map(&:id)

      Photo.change_position_of ids

      expect(Photo.ordered.pluck(:id)).to eq ids
    end

    it "can scope the photos" do
      photo_1 = create :photo
      photo_2 = create :photo, position: 2

      Photo.change_position_of [photo_1, photo_2].map(&:id), event_id: photo_1.event_id

      expect(Photo.ordered.pluck(:id)).to eq [photo_2, photo_1].map(&:id)
    end

    it "can work with no ids" do
      expect { Photo.change_position_of nil }.not_to raise_error
    end
  end

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
