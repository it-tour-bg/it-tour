module ScheduleHelper
  def render_schedule_json(event)
    return {} unless event.sessions_announced?

    event.sessions.map { |s| ScheduleSessionSerializer.new(s)  }.group_by(&:track).to_json
  end

  class ScheduleSessionSerializer
    attr_reader :session

    delegate :track, to: :session

    def initialize(session)
      @session = session
    end

    def as_json(options = {})
      {
        title:     session.title,
        startTime: start_time,
        speakers:  speakers_hash
      }
    end

    private

    def start_time
      date = session.event.date

      hour, minute = session.start_at.split(':')

      Time.new(date.year, date.month, date.day, hour.to_i, minute.to_i)
    end

    def speakers_hash
      session.speakers.map do |speaker|
        {
          name:         speaker.name,
          description:  speaker.description,
        }
      end
    end
  end
end

