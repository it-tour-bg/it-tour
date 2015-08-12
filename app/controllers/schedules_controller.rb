class SchedulesController < ApplicationController
  before_action :set_access_control_headers

  def index
    event = current_conference.current_event
    redirect_to schedule_path(event.name, format: :json)
  end

  def show
    @event = current_conference.announced_event_named(params[:id])
  end

  private
  def set_access_control_headers
    if request.format.json?
      response.headers['Access-Control-Allow-Origin'] = '*'
      response.headers['Access-Control-Request-Method'] = '*'
    end
  end
end
