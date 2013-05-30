class Admin::SubscribersController < Admin::BaseController
  def index
    @subscribers = Subscriber.all
  end

  def create
    @subscriber = Subscriber.create subscriber_params
    flash[:alert] = @subscriber.error_message
    redirect_to return_to_path
  end

  def update
    @subscriber = Subscriber.update subscriber_id, subscriber_params
    flash[:alert] = @subscriber.error_message
    redirect_to return_to_path
  end

  def destroy
    @subscriber = Subscriber.destroy subscriber_id
    redirect_to return_to_path
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

  def return_to_path
    admin_subscribers_path conference_id: @subscriber.conference_id
  end
end



