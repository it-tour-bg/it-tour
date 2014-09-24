class EventDecorator < Draper::Decorator
  decorates :event
  delegate_all

  delegate :about, :about?, to: :conference

  def favicon
    logo.url :favicon
  end

  def formatted_date
    h.l date, format: :long
  end

  def speakers
    sessions.map(&:speakers).flatten
  end

  def start_time_for_javascript
    start_time.rfc2822
  end

  def ongoing?
    Time.current.between? start_time, finish_time
  end

  def finished?
    Time.current > finish_time
  end

  def other_conference_events?
    other_conference_events.any?
  end

  def other_conference_events
    @other_conference_events ||= conference.events.publicly_announced
  end

  def information
    information = []
    information << l(date, format: :long) if dates_announced?
    information << venue_name if venue_announced?
    information.join ', '
  end

  def show_call_to_papers?
    call_to_papers_url? && !sessions_announced?
  end

  def after_party_venue_map?
    after_party_venue_map_url? && after_party_venue_map_embedded_url?
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
    # FIXME: Add time zone to choose from in the admin interface?
    Time.new(date.year, date.month, date.day, hours, minutes, 0, "+03:00")
  end
end
