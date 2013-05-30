require 'spec_helper'

describe Admin::EventsController do
  stub_current_user
  stub_rendering

  let(:event) { double :event }

  describe "GET index" do
    it "assigns all events" do
      Event.stub all: [event]
      get :index
      expect(assigns[:events]).to eq [event]
    end
  end

  describe "GET new" do
    it "assigns new event" do
      Event.stub new: event
      get :new
      expect(assigns[:event]).to eq event
    end
  end

  describe "POST create" do
    before do
      Event.stub(:create).with('name' => 'VarnaConf').and_return event
    end

    it "creates a new event" do
      Event.should_receive(:create).with('name' => 'VarnaConf').and_return event
      post :create, event: {name: 'VarnaConf'}
    end

    it "assigns the new event" do
      post :create, event: {name: 'VarnaConf'}
      expect(assigns[:event]).to eq event
    end

    it "responds with the new event" do
      controller.should_receive(:respond_with).with event, location: admin_event_path(event)
      post :create, event: {name: 'VarnaConf'}
    end
  end

  describe "GET show" do
    it "assigns the event" do
      Event.stub(:find).with('1').and_return event
      get :show, id: '1'
      expect(assigns[:event]).to eq event
    end
  end

  describe "GET edit" do
    it "assigns the event" do
      Event.stub(:find).with('1').and_return event
      get :edit, id: '1'
      expect(assigns[:event]).to eq event
    end
  end

  describe "PATCH update" do
    before do
      Event.stub(:update).with('1', 'name' => 'VarnaConf').and_return event
    end

    it "updates the event" do
      Event.should_receive(:update).with('1', 'name' => 'VarnaConf').and_return event
      patch :update, id: '1', event: {name: 'VarnaConf'}
    end

    it "assigns the event" do
      patch :update, id: '1', event: {name: 'VarnaConf'}
      expect(assigns[:event]).to eq event
    end

    it "responds with the event" do
      controller.should_receive(:respond_with).with event, location: admin_event_path(event)
      patch :update, id: '1', event: {name: 'VarnaConf'}
    end
  end

  describe "DELETE destroy" do
    before do
      Event.stub destroy: event
    end

    it "removes the event" do
      Event.should_receive(:destroy).with('1')
      delete :destroy, id: '1'
    end

    it "redirects to events list" do
      controller.should_receive(:respond_with).with event, location: admin_events_path
      delete :destroy, id: '1'
    end
  end
end

