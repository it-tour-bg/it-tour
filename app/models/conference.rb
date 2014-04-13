class Conference < ActiveRecord::Base
  validates :name, presence: true
  validates :domain, uniqueness: true

  has_many :events, dependent: :destroy
  has_many :subscribers, dependent: :nullify

  after_save :ensure_only_one_main, if: :main?

  class << self
    def find_for_domain(domain)
      where(domain: domain).first!
    end

    def regular
      where(main: false)
    end

    def with_events
      includes(:events).where('events.publicly_announced' => true)
    end
  end

  def current_event
    @current_event = events.publicly_announced.order('current DESC').first!
  end

  def announced_event_named(name)
    events.publicly_announced.find_by! name: name
  end

  def regular?
    !main?
  end

  private

  def ensure_only_one_main
    self.class.where('id != ? AND main', id).update_all main: false
  end
end
