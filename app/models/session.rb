class Session < ActiveRecord::Base
  belongs_to :event
  belongs_to :speaker

  validates :event, presence: true
  validates :start_at, presence: true
  validates :title, presence: true
end
