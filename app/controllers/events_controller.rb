class EventsController < ApplicationController
  def index
    @event = current_conference.current_event
    render :show
  end

  def show
    @event = current_conference.finished_event_for_year(params[:year])
  end

  private

  def current_conference
    Conference.find_for_domain('varnaconf.com')#request.domain)
  end
end
