class Feedback < ActiveRecord::Base
  belongs_to :event

  validates :comment, presence: true
  validates :event, presence: true

  default_scope ->{ order('id DESC') }

  def event_name
    event.full_name
  end
end
