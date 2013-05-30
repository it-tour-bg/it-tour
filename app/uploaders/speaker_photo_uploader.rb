class SpeakerPhotoUploader < CarrierWave::Uploader::Base
  include ImageUploader

  version :thumb do
    process resize_to_fill: [100, 100]
  end
end
