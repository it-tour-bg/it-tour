require 'spec_helper'

describe SpeakerPhotoUploader do
  include CarrierWave::Test::Matchers

  let(:speaker)  { create :speaker }
  let(:uploader) { SpeakerPhotoUploader.new speaker, :photo }

  before do
    SpeakerPhotoUploader.enable_processing = true
    uploader.store! File.open Rails.root.join('spec', 'fixtures', 'speaker_photo.jpg')
  end

  after do
    SpeakerPhotoUploader.enable_processing = false
    FileUtils.rm_r Rails.root.join('public', uploader.store_dir)
  end

  it "has a version - thumb 80x80" do
    expect(uploader.thumb).to have_dimensions 80, 80
  end
end
