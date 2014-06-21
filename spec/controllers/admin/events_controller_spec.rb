require 'spec_helper'

describe Admin::EventsController do
  include SpecSupport::Controllers::RespondWith

  stub_current_user

  let(:event) { double :event }

  describe "GET index" do
    it "assigns all events" do
      allow(Event).to receive(:all).and_return [event]
      get :index
      expect(assigns[:events]).to eq [event]
    end
  end

  describe "GET new" do
    it "assigns new event" do
      allow(Event).to receive(:new).and_return event
      get :new
      expect(assigns[:event]).to eq event
    end
  end

  describe "POST create" do
    before do
      allow(Event).to receive(:create).with('name' => 'VarnaConf').and_return event
    end

    it "creates a new event" do
      post :create, event: {name: 'VarnaConf'}
      expect(Event).to have_received(:create).with('name' => 'VarnaConf')
    end

    it "assigns the new event" do
      post :create, event: {name: 'VarnaConf'}
      expect(assigns[:event]).to eq event
    end

    it "responds with the new event" do
      post :create, event: {name: 'VarnaConf'}
      expect(controller).to respond_with event, location: admin_events_path
    end
  end

  describe "GET show" do
    it "assigns the event" do
      allow(Event).to receive(:find).with('1').and_return event
      get :show, id: '1'
      expect(assigns[:event]).to eq event
    end
  end

  describe "GET edit" do
    it "assigns the event" do
      allow(Event).to receive(:find).with('1').and_return event
      get :edit, id: '1'
      expect(assigns[:event]).to eq event
    end
  end

  describe "PATCH update" do
    before do
      allow(Event).to receive(:update).with('1', 'name' => 'VarnaConf').and_return event
    end

    it "updates the event" do
      patch :update, id: '1', event: {name: 'VarnaConf'}
      expect(Event).to have_received(:update).with('1', 'name' => 'VarnaConf')
    end

    it "assigns the event" do
      patch :update, id: '1', event: {name: 'VarnaConf'}
      expect(assigns[:event]).to eq event
    end

    it "responds with the event" do
      patch :update, id: '1', event: {name: 'VarnaConf'}
      expect(controller).to respond_with event, location: admin_event_path(event)
    end
  end

  describe "DELETE destroy" do
    before do
      allow(Event).to receive(:destroy).with('1').and_return event
    end

    it "removes the event" do
      delete :destroy, id: '1'
      expect(Event).to have_received(:destroy).with('1')
    end

    it "redirects to events list" do
      delete :destroy, id: '1'
      expect(controller).to respond_with event, location: admin_events_path
    end
  end
end
