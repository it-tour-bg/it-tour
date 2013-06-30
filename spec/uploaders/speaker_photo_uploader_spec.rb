require 'spec_helper'

describe SpeakerPhotoUploader, type: :uploader do
  uploader('speaker_photo.jpg') { SpeakerPhotoUploader.new create(:event), :photo }

  it "has a version - thumb 80x80" do
    expect(uploader.thumb).to have_dimensions 80, 80
  end
end
