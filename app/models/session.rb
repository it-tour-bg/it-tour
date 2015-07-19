class Session < ActiveRecord::Base
  validates :event, presence: true
  validates :title, presence: true
  validates :track, numericality: {only_integer: true, allow_nil: false}
  validates :start_at, presence: true, format: {with: /\A[0-9]{2}:[0-9]{2}\Z/}

  attr_readonly :event_id

  belongs_to :event

  has_many :session_speakers, dependent: :destroy
  has_many :speakers, through: :session_speakers

  default_scope -> { order 'start_at ASC' }

  scope :announced, -> { joins(:event).where('events.sessions_announced' => true) }


  delegate :full_name, to: :event, prefix: true

  class << self
    def by_track
      all.group_by &:track
    end
  end
end
