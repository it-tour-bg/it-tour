class ConferencesController < ApplicationController
  def show
    unless current_conference.main?
      @event = EventDecorator.decorate current_conference.current_event
      render 'events/show'
    end
  end
end
