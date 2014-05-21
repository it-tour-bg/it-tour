class Speaker < ActiveRecord::Base
  has_many :sessions, dependent: :nullify, order: 'sessions.id ASC'

  validates :name, presence: true

  mount_uploader :photo, SpeakerPhotoUploader

  default_scope ->{ order 'name ASC' }
end
