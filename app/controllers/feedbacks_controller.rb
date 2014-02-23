class FeedbacksController < ApplicationController
  def new
  end

  def create
    @feedback = Feedback.create feedback_params

    if @feedback.valid?
      render :create
    else
      render :new
    end
  end

  private

  def feedback_params
    params.require(:feedback).permit(:comment, :event_id)
  end
end
