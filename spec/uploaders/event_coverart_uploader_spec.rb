require 'spec_helper'

describe EventCoverartUploader, type: :uploader do
  uploader('event_coverart.jpg') { EventCoverartUploader.new create(:event), :coverart }

  it "has a default version with 900px width" do
    expect(uploader.default).to have_dimensions 900, 675
  end
end


