require 'spec_helper'

describe Admin::SubscribersController do
  stub_current_user
  stub_rendering

  let(:subscriber) { double :subscriber, conference_id: '2' }

  describe "GET index" do
    it "assign filtered subscribers list" do
      Subscriber.stub(:filter).with({'key' => 'value'}).and_return [subscriber]
      get :index, filter: {key: 'value'}
      expect(assigns[:subscribers]).to eq [subscriber]
    end
  end

  describe "POST create" do
    before do
      Subscriber.stub create: subscriber
      subscriber.stub error_message: nil
    end

    it "creates a new subscriber" do
      Subscriber.should_receive(:create).with('email' => 'address').and_return subscriber
      post :create, subscriber: {email: 'address'}
    end

    it "assigns the new subscriber" do
      post :create, subscriber: {some: 'attributes'}
      expect(assigns[:subscriber]).to eq subscriber
    end

    it "sets the flash alert to subscriber error message (if some)" do
      subscriber.stub error_message: 'Error message'
      post :create, subscriber: {some: 'attributes'}
      expect(flash[:alert]).to eq 'Error message'
    end

    it "redirects to admin conference subscribers list" do
      post :create, subscriber: {some: 'attributes'}
      expect(controller).to redirect_to admin_subscribers_path(conference_id: '2')
    end
  end

  describe "PATCH update" do
    before do
      Subscriber.stub update: subscriber
      subscriber.stub error_message: nil
    end

    it "updates the subscriber" do
      Subscriber.should_receive(:update).with('1', 'email' => 'address').and_return subscriber
      patch :update, id: 1, subscriber: {email: 'address'}
    end

    it "assigns the subscriber" do
      patch :update, id: 1, subscriber: {some: 'attributes'}
      expect(assigns[:subscriber]).to eq subscriber
    end

    it "sets the flash alert to subscriber error message (if some)" do
      subscriber.stub error_message: 'Error message'
      patch :update, id: 1, subscriber: {some: 'attributes'}
      expect(flash[:alert]).to eq 'Error message'
    end

    it "redirects to admin conference subscribers list" do
      patch :update, id: 1, subscriber: {some: 'attributes'}
      expect(controller).to redirect_to admin_subscribers_path(conference_id: '2')
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



