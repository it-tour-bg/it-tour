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

    def without_main
      where(main: false)
    end
  end

  def current_event
    events.publicly_announced.order('current DESC').first!
  end

  def announced_event_named(name)
    events.publicly_announced.find_by! name: name
  end

  private

  def ensure_only_one_main
    self.class.where('id != ? AND main', id).update_all main: false
  end
end
