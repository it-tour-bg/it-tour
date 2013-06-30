require 'spec_helper'

describe PhotoAssetUploader, type: :uploader do
  uploader('photo_asset.jpg') { PhotoAssetUploader.new create(:photo), :asset }

  it "has a version - thumb 250x250" do
    expect(uploader.thumb).to have_dimensions 250, 250
  end
end

