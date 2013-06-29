require 'spec_helper'

describe FeedbacksController do
  describe "GET 'new'" do
    it "renders new action" do
      get :new
      expect(controller).to render_template :new
    end
  end

  describe "POST 'create'" do
    let(:feedback) { double 'Feedback', valid?: true }

    before do
      Feedback.stub create: feedback
    end

    it "creates a new feedback" do
      Feedback.should_receive(:create).with('comment' => 'text', 'event_id' => '1')
      post :create, feedback: {comment: 'text', event_id: 1}
    end

    it "renders create action if feedback is valid" do
      feedback.stub valid?: true
      post :create, feedback: {comment: 'text'}
      expect(controller).to render_template :create
    end

    it "renders new action if feedback is not valid" do
      feedback.stub valid?: false
      post :create, feedback: {comment: 'text'}
      expect(controller).to render_template :new
    end
  end
end

