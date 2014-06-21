require 'spec_helper'

describe FeedbacksController do
  describe "POST 'create'" do
    let(:feedback) { double 'Feedback', valid?: true }

    before do
      allow(Feedback).to receive(:create).and_return feedback
    end

    it "creates a new feedback" do
      post :create, feedback: {comment: 'text', event_id: 1}
      expect(Feedback).to have_received(:create).with('comment' => 'text', 'event_id' => '1')
    end

    it "renders create action if feedback is valid" do
      allow(feedback).to receive(:valid?).and_return true
      post :create, feedback: {comment: 'text'}
      expect(controller).to render :create
    end

    it "renders new action if feedback is not valid" do
      allow(feedback).to receive(:valid?).and_return false
      post :create, feedback: {comment: 'text'}
      expect(controller).to render :new
    end
  end
end

