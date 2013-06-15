class SubscribersController < ApplicationController
  def new
  end

  def create
    @subscriber = Subscriber.create conference: current_conference, email: params[:subscriber][:email]

    if @subscriber.valid?
      render :create
    else
      render :new
    end
  end
end

