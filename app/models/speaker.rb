class Speaker < ActiveRecord::Base
  has_many :session_speakers, dependent: :destroy
  has_many :sessions, through: :session_speakers

  validates :name, presence: true

  mount_uploader :photo, SpeakerPhotoUploader

  default_scope ->{ order 'name ASC' }
end
