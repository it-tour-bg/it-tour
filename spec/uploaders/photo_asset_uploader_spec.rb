require 'spec_helper'

describe PhotoAssetUploader do
  include CarrierWave::Test::Matchers

  let(:photo)  { create :photo }
  let(:uploader) { PhotoAssetUploader.new photo, :asset }

  before do
    PhotoAssetUploader.enable_processing = true
    uploader.store! File.open Rails.root.join('spec', 'fixtures', 'photo_asset.jpg')
  end

  after do
    PhotoAssetUploader.enable_processing = false
    FileUtils.rm_r Rails.root.join('public', uploader.store_dir)
  end

  it "has a version - thumb 250x250" do
    expect(uploader.thumb).to have_dimensions 250, 250
  end
end

