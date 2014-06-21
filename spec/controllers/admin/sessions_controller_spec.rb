require 'spec_helper'

describe Admin::SessionsController do
  stub_current_user

  let(:session) { double :session, event: double(:event) }

  describe "GET new" do
    it "assigns new session with given session id" do
      allow(Session).to receive(:new).with(event_id: '1').and_return session
      get :new, event_id: '1'
      expect(assigns[:session]).to eq session
    end
  end

  describe "POST create" do
    before do
      allow(Session).to receive(:create).with('title' => 'Opening').and_return session
    end

    it "creates a new session" do
      post :create, session: {title: 'Opening'}
      expect(Session).to have_received(:create).with('title' => 'Opening')
    end

    it "assigns the new session" do
      post :create, session: {title: 'Opening'}
      expect(assigns[:session]).to eq session
    end

    it "responds with the new session" do
      post :create, session: {title: 'Opening'}
      expect(controller).to respond_with session, location: admin_event_path(session.event, anchor: 'sessions')
    end
  end

  describe "GET edit" do
    it "assigns the session" do
      allow(Session).to receive(:find).with('1').and_return session
      get :edit, id: '1'
      expect(assigns[:session]).to eq session
    end
  end

  describe "PATCH update" do
    before do
      allow(Session).to receive(:update).with('1', 'title' => 'Opening').and_return session
    end

    it "updates the session" do
      patch :update, id: '1', session: {title: 'Opening'}
      expect(Session).to have_received(:update).with('1', 'title' => 'Opening')
    end

    it "assigns the session" do
      patch :update, id: '1', session: {title: 'Opening'}
      expect(assigns[:session]).to eq session
    end

    it "responds with the session" do
      patch :update, id: '1', session: {title: 'Opening'}
      expect(controller).to respond_with session, location: admin_event_path(session.event, anchor: 'sessions')
    end
  end

  describe "DELETE destroy" do
    before do
      allow(Session).to receive(:destroy).and_return session
    end

    it "removes the session" do
      delete :destroy, id: '1'
      expect(Session).to have_received(:destroy).with('1')
    end

    it "redirects to sessions list" do
      delete :destroy, id: '1'
      expect(controller).to respond_with session, location: admin_event_path(session.event, anchor: 'sessions')
    end
  end
end


