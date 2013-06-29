class Feedback < ActiveRecord::Base
  belongs_to :event

  validates :comment, presence: true
  validates :event, presence: true

  default_scope ->{ order('id DESC') }

  scope :for_event, ->(event_id) { where event_id: event_id }

  class << self
    def for_event(event_id)
      if event_id.present?
        where event_id: event_id
      else
        all
      end
    end
  end

  def event_name
    event.full_name
  end
end
