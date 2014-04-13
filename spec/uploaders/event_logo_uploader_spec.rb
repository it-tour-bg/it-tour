require 'spec_helper'

describe EventLogoUploader, type: :uploader do
  uploader('event_logo.png') { EventLogoUploader.new create(:event), :logo }

  it "has a version - favicon 50x50" do
    expect(uploader.favicon).to have_dimensions 50, 50
  end

  it "has a version - thumb 88x88" do
    expect(uploader.thumb).to have_dimensions 88, 88
  end
end

