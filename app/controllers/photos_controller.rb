class PhotosController < ApplicationController
  def index
    @event  = EventDecorator.decorate current_conference.announced_event_named(params[:year])
    @photos = @event.photos.ordered
  end
end
