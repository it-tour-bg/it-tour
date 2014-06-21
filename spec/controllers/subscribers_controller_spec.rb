require 'spec_helper'

describe SubscribersController do
  set_current_conference

  describe "GET 'new'" do
    it "renders new action" do
      get :new
      expect(controller).to render_template :new
    end
  end

  describe "POST 'create'" do
    let(:subscriber) { double 'Subscriber', valid?: true }

    before do
      Subscriber.stub subscribe: subscriber
    end

    it "creates a new subscriber" do
      Subscriber.should_receive(:subscribe).with('email@example.org', current_conference)
      post :create, subscriber: {email: 'email@example.org'}
    end

    it "renders create action if subscriber is valid" do
      subscriber.stub valid?: true
      post :create, subscriber: {email: 'email@example.org'}
      expect(controller).to render_template :create
    end

    it "renders new action if subscriber is not valid" do
      subscriber.stub valid?: false
      post :create, subscriber: {email: 'email@example.org'}
      expect(controller).to render_template :new
    end
  end
end
