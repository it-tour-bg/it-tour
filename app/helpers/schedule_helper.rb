module ScheduleHelper
  def render_schedule_json(event)
    return {} unless event.sessions_announced?

    event.sessions.map { |s| ScheduleSessionSerializer.new(s)  }.group_by(&:track).to_json
  end
end

