class Admin::SpeakersController < Admin::BaseController
  def index
    @speakers = Speaker.all
  end

  def new
    @speaker = Speaker.new
  end

  def create
    @speaker = Speaker.create speaker_params
    respond_with @speaker, location: admin_speakers_path
  end

  def show
    @speaker = Speaker.find speaker_id
  end

  def edit
    @speaker = Speaker.find speaker_id
  end

  def update
    @speaker = Speaker.update speaker_id, speaker_params
    respond_with @speaker, location: admin_speakers_path
  end

  def destroy
    @speaker = Speaker.destroy speaker_id
    respond_with @speaker, location: admin_speakers_path
  end

  private

  def speaker_id
    params[:id]
  end

  def speaker_params
    params.require(:speaker).permit(
      :name,
      :description,
      :personal_site,
      :company,
      :company_site,
      :twitter_account,
      :photo,
    )
  end
end
