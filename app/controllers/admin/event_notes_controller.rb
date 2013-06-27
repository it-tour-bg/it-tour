class Admin::EventNotesController < Admin::BaseController
  def edit
    @event = Event.find event_id
  end

  def update
    @event = Event.update event_id, notes: params[:event][:notes]
    respond_with @event, location: admin_event_path(@event, anchor: 'notes')
  end

  private

  def event_id
    params[:event_id]
  end
end

