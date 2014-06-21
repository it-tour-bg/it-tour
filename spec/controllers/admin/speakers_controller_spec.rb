require 'spec_helper'

describe Admin::SpeakersController do
  include SpecSupport::Controllers::RespondWith

  stub_current_user

  let(:speaker) { double :speaker }

  describe "GET index" do
    it "assigns all speakers" do
      allow(Speaker).to receive(:all).and_return [speaker]
      get :index
      expect(assigns[:speakers]).to eq [speaker]
    end
  end

  describe "GET new" do
    it "assigns new speaker" do
      allow(Speaker).to receive(:new).and_return speaker
      get :new
      expect(assigns[:speaker]).to eq speaker
    end
  end

  describe "POST create" do
    before do
      allow(Speaker).to receive(:create).with('name' => 'VarnaConf').and_return speaker
    end

    it "creates a new speaker" do
      post :create, speaker: {name: 'VarnaConf'}
      expect(Speaker).to have_received(:create).with('name' => 'VarnaConf')
    end

    it "assigns the new speaker" do
      post :create, speaker: {name: 'VarnaConf'}
      expect(assigns[:speaker]).to eq speaker
    end

    it "responds with the new speaker" do
      post :create, speaker: {name: 'VarnaConf'}
      expect(controller).to respond_with speaker, location: admin_speakers_path
    end
  end

  describe "GET show" do
    it "assigns the speaker" do
      allow(Speaker).to receive(:find).with('1').and_return speaker
      get :show, id: '1'
      expect(assigns[:speaker]).to eq speaker
    end
  end


  describe "GET edit" do
    it "assigns the speaker" do
      allow(Speaker).to receive(:find).with('1').and_return speaker
      get :edit, id: '1'
      expect(assigns[:speaker]).to eq speaker
    end
  end

  describe "PATCH update" do
    before do
      allow(Speaker).to receive(:update).with('1', 'name' => 'VarnaConf').and_return speaker
    end

    it "updates the speaker" do
      patch :update, id: '1', speaker: {name: 'VarnaConf'}
      expect(Speaker).to have_received(:update).with('1', 'name' => 'VarnaConf')
    end

    it "assigns the speaker" do
      patch :update, id: '1', speaker: {name: 'VarnaConf'}
      expect(assigns[:speaker]).to eq speaker
    end

    it "responds with the speaker" do
      patch :update, id: '1', speaker: {name: 'VarnaConf'}
      expect(controller).to respond_with speaker, location: admin_speakers_path
    end
  end

  describe "DELETE destroy" do
    before do
      allow(Speaker).to receive(:destroy).with('1').and_return speaker
    end

    it "removes the speaker" do
      delete :destroy, id: '1'
      expect(Speaker).to have_received(:destroy).with('1')
    end

    it "redirects to speakers list" do
      delete :destroy, id: '1'
      expect(controller).to respond_with speaker, location: admin_speakers_path
    end
  end
end
