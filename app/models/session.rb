class Session < ActiveRecord::Base
  belongs_to :event
  belongs_to :speaker

  validates :event, presence: true
  validates :title, presence: true
  validates :start_at, presence: true, format: {with: /\A[0-9]{2}:[0-9]{2}\Z/}

  attr_readonly :event_id

  default_scope -> { order 'start_at ASC' }
end
