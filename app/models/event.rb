class Event < ActiveRecord::Base
  validates :name, presence: true
  validates :conference, presence: true
  validates :date, presence: true

  validate :ensure_current_event_is_visible

  after_save :ensure_only_one_current_event_in_conference, if: :current?

  attr_readonly :conference_id

  belongs_to :conference

  has_many :sessions, dependent: :destroy
  has_many :feedbacks, dependent: :destroy
  has_many :photos, dependent: :destroy

  mount_uploader :logo, EventLogoUploader
  mount_uploader :coverart, EventCoverartUploader

  scope :publicly_announced, ->{ order('date DESC').where publicly_announced: true }

  default_scope ->{ order('name DESC') }

  delegate :domain, to: :conference

  def full_name
    "#{conference.name} #{name}"
  end

  private

  def ensure_current_event_is_visible
    errors.add :current, 'should be publicly announced' if current? and not publicly_announced?
  end

  def ensure_only_one_current_event_in_conference
    conference.events.where('id != ? AND current', id).update_all current: false
  end
end
