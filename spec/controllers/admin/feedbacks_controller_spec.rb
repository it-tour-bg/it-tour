require 'spec_helper'

describe Admin::FeedbacksController do
  stub_current_user

  describe "GET 'index'" do
    it "assigns selected event" do
      Event.stub(:find).with('1').and_return 'event'
      get :index, event_id: 1
      expect(assigns[:event]).to eq 'event'
    end
  end

  describe "DELETE destroy" do
    before do
      Feedback.stub(:destroy).with('1').and_return double(:feedback, event_id: '2')
    end

    it "removes the feedback" do
      Feedback.should_receive(:destroy).with('1')
      delete :destroy, id: '1'
    end

    it "redirects to feedbacks list" do
      delete :destroy, id: '1'
      expect(controller).to redirect_to admin_event_feedbacks_path(event_id: '2')
    end
  end
end
