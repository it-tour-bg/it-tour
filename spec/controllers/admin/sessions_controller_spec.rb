require 'spec_helper'

describe Admin::SessionsController do
  stub_current_user
  stub_rendering

  let(:session) { double :session, event: double(:event) }

  describe "GET new" do
    it "assigns new session with given session id" do
      Session.stub(:new).with(event_id: '1').and_return session
      get :new, event_id: '1'
      expect(assigns[:session]).to eq session
    end
  end

  describe "GET create" do
    before do
      Session.stub(:create).with('title' => 'Opening').and_return session
    end

    it "creates a new session" do
      Session.should_receive(:create).with('title' => 'Opening').and_return session
      get :create, session: {title: 'Opening'}
    end

    it "assigns the new session" do
      get :create, session: {title: 'Opening'}
      expect(assigns[:session]).to eq session
    end

    it "responds with the new session" do
      controller.should_receive(:respond_with).with(session, location: admin_event_path(session.event))
      get :create, session: {title: 'Opening'}
    end
  end

  describe "GET edit" do
    it "assigns the session" do
      Session.stub(:find).with('1').and_return session
      get :edit, id: '1'
      expect(assigns[:session]).to eq session
    end
  end

  describe "GET update" do
    before do
      Session.stub(:update).with('1', 'title' => 'Opening').and_return session
    end

    it "updates the session" do
      Session.should_receive(:update).with('1', 'title' => 'Opening').and_return session
      put :update, id: '1', session: {title: 'Opening'}
    end

    it "assigns the session" do
      put :update, id: '1', session: {title: 'Opening'}
      expect(assigns[:session]).to eq session
    end

    it "responds with the session" do
      controller.should_receive(:respond_with).with(session, location: admin_event_path(session.event))
      put :update, id: '1', session: {title: 'Opening'}
    end
  end

  describe "DELETE destroy" do
    before do
      Session.stub(:destroy).with('1')
    end

    it "removes the session" do
      Session.should_receive(:destroy).with('1')
      delete :destroy, id: '1'
    end

    it "redirects to sessions list" do
      delete :destroy, id: '1'
      expect(controller).to redirect_to admin_sessions_path
    end
  end
end


