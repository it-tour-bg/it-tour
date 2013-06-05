class Conference < ActiveRecord::Base
  validates :name, presence: true
  validates :contact_name, presence: true
  validates :contact_email, presence: true
  validates :domain, uniqueness: true

  has_many :events, dependent: :destroy
  has_many :subscribers, dependent: :nullify

  class << self
    def find_for_domain(domain)
      where(domain: domain).first!
    end
  end

  def current_event
    events.where(state: 'current').first!
  end
end
