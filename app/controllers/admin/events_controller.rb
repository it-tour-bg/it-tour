class Admin::EventsController < Admin::BaseController
  def index
    @events = Event.all
  end

  def new
    @event = Event.new
  end

  def create
    @event = Event.create event_params
    respond_with @event, location: admin_events_path
  end

  def show
    @event = Event.find event_id
  end

  def edit
    @event = Event.find event_id
  end

  def update
    @event = Event.update event_id, event_params
    respond_with @event, location: admin_event_path(@event)
  end

  def destroy
    @event = Event.destroy event_id
    respond_with @event, location: admin_events_path
  end

  private

  def event_id
    params[:id]
  end

  def event_params
    params.require(:event).permit(
      :conference_id,
      :name,
      :current,
      :date,
      :town,
      :publicly_announced,
      :event_url,
      :venue_name,
      :venue_site_url,
      :venue_address,
      :venue_map_url,
      :venue_map_embedded_url,
      :venue_notes,
      :after_party_venue_name,
      :after_party_venue_site_url,
      :after_party_venue_address,
      :after_party_venue_map_url,
      :after_party_venue_map_embedded_url,
      :after_party_venue_notes,
      :dates_announced,
      :venue_announced,
      :after_party_announced,
      :sessions_announced,
      :speakers_announced,
      :logo,
      :coverart,
      :streaming_code,
      :show_feedback_form,
      :show_photo_gallery,
      :show_streaming,
      :show_coverart,
      :color,
      :call_to_papers_url,
      :sponsor_embed,
      :show_sponsor_embed,
    )
  end
end

