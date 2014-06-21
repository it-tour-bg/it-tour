require 'spec_helper'

describe Admin::FeedbacksController do
  stub_current_user

  describe "GET 'index'" do
    it "assigns selected event" do
      allow(Event).to receive(:find).with('1').and_return 'event'
      get :index, event_id: 1
      expect(assigns[:event]).to eq 'event'
    end
  end

  describe "DELETE destroy" do
    before do
      allow(Feedback).to receive(:destroy).with('1').and_return double(:feedback, event_id: '2')
    end

    it "removes the feedback" do
      delete :destroy, id: '1'
      expect(Feedback).to have_received(:destroy).with('1')
    end

    it "redirects to feedbacks list" do
      delete :destroy, id: '1'
      expect(controller).to redirect_to admin_event_feedbacks_path(event_id: '2')
    end
  end
end
