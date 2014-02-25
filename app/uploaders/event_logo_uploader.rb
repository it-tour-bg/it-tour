class EventLogoUploader < CarrierWave::Uploader::Base
  include ImageUploader

  version :favicon do
    process resize_to_fill: [50, 50]
  end

  version :thumb do
    process resize_to_fill: [88, 88]
  end

  version :main do
    process resize_to_fill: [250, 250]
  end
end

