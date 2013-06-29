class Feedback < ActiveRecord::Base
  belongs_to :event

  validates :comment, presence: true
  validates :event, presence: true

  default_scope ->{ order('id DESC') }
end
