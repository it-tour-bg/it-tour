class EventCoverartUploader < CarrierWave::Uploader::Base
  include ImageUploader

  version :default do
    process resize_to_limit: [900, 900]
  end
end


