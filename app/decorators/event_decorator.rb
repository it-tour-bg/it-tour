#encoding: utf-8
class EventDecorator < Draper::Decorator
  decorates :event
  delegate_all

  delegate :name, :slogan, to: :conference, prefix: true

  def favicon
    logo.url :favicon
  end

  def formatted_date
    h.l date, format: :long
  end

  def speakers
    sessions.map(&:speaker).compact
  end

  def start_time_for_javascript
    start_time.rfc2822
  end

  def ongoing?
    Time.now.between? start_time, finish_time
  end

  def finished?
    Time.now > finish_time
  end

  private

  def start_time
    session_time sessions.first
  end

  def finish_time
    session_time sessions.last
  end

  def session_time(session)
    start_at = session.try(:start_at) || ''
    hours, minutes = start_at.split ':'
    Time.new(date.year, date.month, date.day, hours, minutes)
  end
end
