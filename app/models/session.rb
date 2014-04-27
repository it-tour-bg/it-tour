class Session < ActiveRecord::Base
  validates :event, presence: true
  validates :title, presence: true
  validates :start_at, presence: true, format: {with: /\A[0-9]{2}:[0-9]{2}\Z/}

  attr_readonly :event_id

  belongs_to :event
  belongs_to :speaker

  default_scope -> { order 'start_at ASC' }

  delegate :name, to: :speaker, prefix: true
  delegate :full_name, to: :event, prefix: true
end
