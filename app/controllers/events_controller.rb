class EventsController < ApplicationController
  def show
    @event = EventDecorator.decorate current_conference.announced_event_named(params[:year])

    if @event.current?
      redirect_to root_path
    end
  end
end
