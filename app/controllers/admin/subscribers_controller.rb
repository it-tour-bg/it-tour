class Admin::SubscribersController < Admin::BaseController
  def index
    @subscribers = Subscriber.all
  end

  def create
    @subscriber = Subscriber.create subscriber_params
    respond_with @subscriber, location: subscribers_path
  end

  def update
    @subscriber = Subscriber.update subscriber_id, subscriber_params
    respond_with @subscriber, location: subscribers_path
  end

  def destroy
    @subscriber = Subscriber.destroy subscriber_id
    redirect_to subscribers_path
  end

  private

  def subscriber_id
    params[:id]
  end

  def subscriber_params
    params.require(:subscriber).permit(
      :email,
      :conference_id,
      :active,
    )
  end

  def respond_with(*args)
    super(*args) do |format|
      format.html { render :show }
    end
  end

  def subscribers_path
    admin_subscribers_path conference_id: @subscriber.conference_id
  end
end



