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

  def start_time
    session_time_in_seconds sessions.first
  end

  def finish_time
    session_time_in_seconds sessions.last
  end

  def ongoing?
    Time.now.between? Time.at(start_time), Time.at(finish_time)
  end

  def finished?
    Time.now > Time.at(finish_time)
  end

  def other_conferences
    @other_conferences ||= Conference.where('id != ?', conference_id).order('name DESC')
  end

  private

  def session_time_in_seconds(session)
    start_at = session.try(:start_at) || ''
    hours, minutes = start_at.split ':'
    date.to_time.to_i + hours.to_i * 60 * 60 + minutes.to_i
  end
end
