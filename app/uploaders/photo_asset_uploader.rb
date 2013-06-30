class PhotoAssetUploader < CarrierWave::Uploader::Base
  include ImageUploader

  version :thumb do
    process resize_to_fill: [250, 250]
  end
end
