class Admin::FeedbacksController < Admin::BaseController
  def index
    @event = Event.find params[:event_id]
  end

  def destroy
    feedback = Feedback.destroy params[:id]
    redirect_to admin_event_feedbacks_path(event_id: feedback.event_id), notice: 'Feedback delete successfully'
  end
end
