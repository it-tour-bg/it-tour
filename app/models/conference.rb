class Conference < ActiveRecord::Base
  validates :name, presence: true
  validates :contact_name, presence: true
  validates :contact_email, presence: true

  has_many :events, dependent: :destroy
  has_many :subscribers, dependent: :nullify
end
