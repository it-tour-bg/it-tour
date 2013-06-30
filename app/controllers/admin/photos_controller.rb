class Admin::PhotosController < Admin::BaseController
  protect_from_forgery except: :create

  def index
    @event = Event.find event_id
  end

  def create
    photo = Photo.create! event_id: event_id, asset: params[:file]
    render json: photo
  end

  def destroy
    Photo.destroy params[:id]
    head :ok
  end

  def reorder
    # TODO
  end

  private

  def event_id
    params[:event_id]
  end
end
