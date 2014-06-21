require 'spec_helper'

describe Admin::ConferencesController do
  include SpecSupport::Controllers::RespondWith

  stub_current_user

  let(:conference) { double :conference }

  describe "GET index" do
    it "assigns all conferences" do
      allow(Conference).to receive(:all).and_return [conference]
      get :index
      expect(assigns[:conferences]).to eq [conference]
    end
  end

  describe "GET new" do
    it "assigns new conference" do
      allow(Conference).to receive(:new).and_return conference
      get :new
      expect(assigns[:conference]).to eq conference
    end
  end

  describe "POST create" do
    before do
      allow(Conference).to receive(:create).with('name' => 'VarnaConf').and_return conference
    end

    it "creates a new conference" do
      post :create, conference: {name: 'VarnaConf'}
      expect(Conference).to have_received(:create).with('name' => 'VarnaConf')
    end

    it "assigns the new conference" do
      post :create, conference: {name: 'VarnaConf'}
      expect(assigns[:conference]).to eq conference
    end

    it "responds with the new conference" do
      post :create, conference: {name: 'VarnaConf'}
      expect(controller).to respond_with conference, location: admin_conferences_path
    end
  end

  describe "GET show" do
    it "assigns the conference" do
      allow(Conference).to receive(:find).with('1').and_return conference
      get :show, id: '1'
      expect(assigns[:conference]).to eq conference
    end
  end

  describe "GET edit" do
    it "assigns the conference" do
      allow(Conference).to receive(:find).with('1').and_return conference
      get :edit, id: '1'
      expect(assigns[:conference]).to eq conference
    end
  end

  describe "PATCH update" do
    before do
      allow(Conference).to receive(:update).with('1', 'name' => 'VarnaConf').and_return conference
    end

    it "updates the conference" do
      patch :update, id: '1', conference: {name: 'VarnaConf'}
      expect(Conference).to have_received(:update).with('1', 'name' => 'VarnaConf')
    end

    it "assigns the conference" do
      patch :update, id: '1', conference: {name: 'VarnaConf'}
      expect(assigns[:conference]).to eq conference
    end

    it "responds with the conference" do
      patch :update, id: '1', conference: {name: 'VarnaConf'}
      expect(controller).to respond_with conference, location: admin_conferences_path
    end
  end

  describe "DELETE destroy" do
    before do
      allow(Conference).to receive(:destroy).with('1').and_return conference
    end

    it "removes the conference" do
      delete :destroy, id: '1'
      expect(Conference).to have_received(:destroy).with('1')
    end

    it "redirects to conferences list" do
      delete :destroy, id: '1'
      expect(controller).to respond_with conference, location: admin_conferences_path
    end
  end
end
