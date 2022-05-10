module ImageUploader
  def self.included(base)
    base.send :include, CarrierWave::RMagick
    base.send :storage, :file
    base.send :version, :original
  end

  def store_dir
    "system/uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end

  def default_url
    ActionController::Base.helpers.asset_path "fallbacks/#{model.class.to_s.underscore}/#{mounted_as}/#{version_name || 'default'}.png"
  end

  def filename
    "image#{File.extname(super)}" if original_filename
  end

  def extension_white_list
    %w(jpg jpeg png gif)
  end

  def url(kind = nil)
    "#{super(kind)}?#{model.updated_at.to_i}"
  end
end
