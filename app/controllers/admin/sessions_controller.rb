class Admin::SessionsController < Admin::BaseController
  def index
    @sessions = Session.all
  end

  def new
    @session = Session.new event_id: params[:event_id]
  end

  def create
    @session = Session.create session_params
    respond_with @session, location: admin_event_path(@session.event)
  end

  def show
    @session = Session.find session_id
  end

  def edit
    @session = Session.find session_id
  end

  def update
    @session = Session.update session_id, session_params
    respond_with @session, location: admin_event_path(@session.event)
  end

  def destroy
    Session.destroy session_id
    redirect_to admin_sessions_path
  end

  private

  def session_id
    params[:id]
  end

  def session_params
    params.require(:session).permit(
      :event_id,
      :speaker_id,
      :title,
      :start_at,
      :slides_url,
      :video_url,
      :description
    )
  end
end


