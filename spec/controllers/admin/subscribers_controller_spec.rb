require 'spec_helper'

describe Admin::SubscribersController do
  stub_current_user
  stub_rendering

  let(:subscriber) { double :subscriber, conference_id: '2' }

  describe "GET create" do
    before do
      Subscriber.stub(:create).with('email' => 'address').and_return subscriber
    end

    it "creates a new subscriber" do
      Subscriber.should_receive(:create).with('email' => 'address').and_return subscriber
      get :create, subscriber: {email: 'address'}
    end

    it "assigns the new subscriber" do
      get :create, subscriber: {email: 'address'}
      expect(assigns[:subscriber]).to eq subscriber
    end

    it "responds with the new subscriber" do
      controller.should_receive(:respond_with).with(subscriber, location: admin_subscribers_path(conference_id: '2'))
      get :create, subscriber: {email: 'address'}
    end
  end

  describe "GET update" do
    before do
      Subscriber.stub(:update).with('1', 'email' => 'address').and_return subscriber
    end

    it "updates the subscriber" do
      Subscriber.should_receive(:update).with('1', 'email' => 'address').and_return subscriber
      put :update, id: '1', subscriber: {email: 'address'}
    end

    it "assigns the subscriber" do
      put :update, id: '1', subscriber: {email: 'address'}
      expect(assigns[:subscriber]).to eq subscriber
    end

    it "responds with the subscriber" do
      controller.should_receive(:respond_with).with(subscriber, location: admin_subscribers_path(conference_id: '2'))
      put :update, id: '1', subscriber: {email: 'address'}
    end
  end

  describe "DELETE destroy" do
    before do
      Subscriber.stub(:destroy).with('1').and_return subscriber
    end

    it "removes the subscriber" do
      Subscriber.should_receive(:destroy).with('1')
      delete :destroy, id: '1'
    end

    it "redirects to subscribers list" do
      delete :destroy, id: '1'
      expect(controller).to redirect_to admin_subscribers_path(conference_id: '2')
    end
  end
end



