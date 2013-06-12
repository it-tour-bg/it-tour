class Event < ActiveRecord::Base
  STATES = %w(future current finished)

  validates :name, presence: true
  validates :conference, presence: true
  validates :date, presence: true
  validates :state, presence: true, inclusion: {in: STATES}

  attr_readonly :conference_id

  belongs_to :conference
  has_many :sessions, dependent: :destroy

  delegate :facebook_account, :twitter_account, :youtube_account, :contact_name, :contact_email, to: :conference

  mount_uploader :logo, EventLogoUploader

  def full_name
    "#{conference.name} #{name}"
  end
end
