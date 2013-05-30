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

  describe "GET create" do
    before do
      Subscriber.stub create: subscriber
      subscriber.stub error_message: nil
    end

    it "creates a new subscriber" do
      Subscriber.should_receive(:create).with('email' => 'address').and_return subscriber
      post_create_subscriber email: 'address'
    end

    it "assigns the new subscriber" do
      post_create_subscriber
      expect(assigns[:subscriber]).to eq subscriber
    end

    it "sets the flash alert to subscriber error message (if some)" do
      subscriber.stub error_message: 'Error message'
      post_create_subscriber
      expect(flash[:alert]).to eq 'Error message'
    end

    it "redirects to admin conference subscribers list" do
      post_create_subscriber
      expect(controller).to redirect_to admin_subscribers_path(conference_id: '2')
    end

    def post_create_subscriber(attributes = {key: 'value'})
      post :create, subscriber: attributes
    end
  end

  describe "GET update" do
    before do
      Subscriber.stub update: subscriber
      subscriber.stub error_message: nil
    end

    it "updates the subscriber" do
      Subscriber.should_receive(:update).with('1', 'email' => 'address').and_return subscriber
      patch_update_subscriber 1, email: 'address'
    end

    it "assigns the subscriber" do
      patch_update_subscriber
      expect(assigns[:subscriber]).to eq subscriber
    end

    it "sets the flash alert to subscriber error message (if some)" do
      subscriber.stub error_message: 'Error message'
      patch_update_subscriber
      expect(flash[:alert]).to eq 'Error message'
    end

    it "redirects to admin conference subscribers list" do
      patch_update_subscriber
      expect(controller).to redirect_to admin_subscribers_path(conference_id: '2')
    end

    def patch_update_subscriber(id = 1, attributes = {key: 'value'})
      patch :update, id: id, subscriber: attributes
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



