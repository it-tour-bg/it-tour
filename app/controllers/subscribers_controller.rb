class SubscribersController < ApplicationController
  layout 'events'

  def new
  end

  def create
    @subscriber = Subscriber.subscribe params[:subscriber][:email], current_conference

    if @subscriber.valid?
      render :create
    else
      render :new
    end
  end
end

