class Admin::FeedbacksController < Admin::BaseController
  def index
    @feedbacks = Feedback.for_event filter_event_id
  end

  def destroy
    feedback = Feedback.destroy params[:id]
    redirect_to admin_feedbacks_path(filter: {event_id: feedback.event_id}), notice: 'Feedback delete successfully'
  end

  private

  def filter_event_id
    params[:filter] && params[:filter][:event_id]
  end
end
