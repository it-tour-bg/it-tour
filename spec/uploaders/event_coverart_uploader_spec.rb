require 'spec_helper'

describe EventCoverartUploader do
  include CarrierWave::Test::Matchers

  let(:event)  { create :event }
  let(:uploader) { EventCoverartUploader.new event, :coverart }

  before do
    EventCoverartUploader.enable_processing = true
    uploader.store! File.open Rails.root.join('spec', 'fixtures', 'event_coverart.jpg')
  end

  after do
    EventLogoUploader.enable_processing = false
    FileUtils.rm_r Rails.root.join('public', uploader.store_dir)
  end

  it "has a default version with 900px width" do
    expect(uploader.default).to have_dimensions 900, 675
  end
end


