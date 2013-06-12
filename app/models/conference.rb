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
    events.find_by! state: 'current'
  end

  def finished_event_named(name)
    events.find_by! state: 'finished', name: name
  end

  def finished_events
    events.where(state: 'finished').order('name ASC')
  end
end
