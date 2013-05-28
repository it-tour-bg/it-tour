class Event < ActiveRecord::Base
  validates :name, presence: true
  validates :conference, presence: true
  validates :date, presence: true

  attr_readonly :conference_id

  belongs_to :conference
  has_many :sessions, dependent: :destroy

  delegate :facebook_account, :twitter_account, :youtube_account, to: :conference

  def full_name
    "#{conference.name} #{name}"
  end
end
