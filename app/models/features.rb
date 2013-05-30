module Features
  extend self

  def s3_uploads?
    Rails.env.production?
  end
end
