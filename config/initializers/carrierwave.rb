
CarrierWave.root = Rails.root.join(Rails.public_path)

if Features.s3_uploads?
  CarrierWave.configure do |config|
    config.fog_directory   = ENV['S3_BUCKET']
    config.fog_public      = true
    config.fog_attributes  = {'Cache-Control' =>'max-age = 315576000'}
    config.fog_credentials = {
      provider:              'AWS',
      aws_access_key_id:     ENV['S3_KEY'],
      aws_secret_access_key: ENV['S3_SECRET']
    }
  end
end
