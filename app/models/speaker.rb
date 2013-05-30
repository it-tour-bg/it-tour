class Speaker < ActiveRecord::Base
  has_many :sessions, dependent: :nullify

  validates :name, presence: true

  mount_uploader :photo, SpeakerPhotoUploader
end
