class Admin::ConferencesController < Admin::BaseController
  def index
    @conferences = Conference.all
  end

  def new
    @conference = Conference.new
  end

  def create
    @conference = Conference.create conference_params
    respond_with @conference, location: admin_conference_path(@conference)
  end

  def show
    @conference = Conference.find conference_id
  end

  def edit
    @conference = Conference.find conference_id
  end

  def update
    @conference = Conference.update conference_id, conference_params
    respond_with @conference, location: admin_conference_path(@conference)
  end

  def destroy
    @conference = Conference.destroy conference_id
    respond_with @conference, location: admin_conferences_path
  end

  private

  def conference_id
    params[:id]
  end

  def conference_params
    params.require(:conference).permit(
      :name,
      :contact_name,
      :contact_email,
      :facebook_account,
      :twitter_account,
      :youtube_account,
    )
  end
end
