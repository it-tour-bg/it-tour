require 'spec_helper'

describe EventLogoUploader do
  include CarrierWave::Test::Matchers

  let(:event)  { create :event }
  let(:uploader) { EventLogoUploader.new event, :logo }

  before do
    EventLogoUploader.enable_processing = true
    uploader.store! File.open Rails.root.join('spec', 'fixtures', 'event_logo.png')
  end

  after do
    EventLogoUploader.enable_processing = false
    FileUtils.rm_r Rails.root.join('public', uploader.store_dir)
  end

  it "has a version - thumb 50x50" do
    expect(uploader.favicon).to have_dimensions 50, 50
  end
end

