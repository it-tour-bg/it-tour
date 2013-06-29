require 'spec_helper'

describe Admin::FeedbacksController do
  stub_current_user
  stub_rendering

  let(:feedback) { double :feedback, event_id: '2' }

  describe "GET index" do
    it "assign filtered feedbacks list" do
      Feedback.stub(:for_event).with('1').and_return [feedback]
      get :index, filter: {event_id: '1'}
      expect(assigns[:feedbacks]).to eq [feedback]
    end
  end

  describe "DELETE destroy" do
    before do
      Feedback.stub(:destroy).with('1').and_return feedback
    end

    it "removes the feedback" do
      Feedback.should_receive(:destroy).with('1')
      delete :destroy, id: '1'
    end

    it "redirects to feedbacks list" do
      delete :destroy, id: '1'
      expect(controller).to redirect_to admin_feedbacks_path(event_id: '2')
    end
  end
end
