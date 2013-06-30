require 'spec_helper'

describe EventLogoUploader, type: :uploader do
  uploader('event_logo.png') { EventLogoUploader.new create(:event), :logo }

  it "has a version - thumb 50x50" do
    expect(uploader.favicon).to have_dimensions 50, 50
  end
end

