require 'spec_helper'

describe Admin::SpeakersController do
  stub_current_user
  stub_rendering

  let(:speaker) { double :speaker }

  describe "GET index" do
    it "assigns all speakers" do
      Speaker.stub all: [speaker]
      get :index
      expect(assigns[:speakers]).to eq [speaker]
    end
  end

  describe "GET new" do
    it "assigns new speaker" do
      Speaker.stub new: speaker
      get :new
      expect(assigns[:speaker]).to eq speaker
    end
  end

  describe "POST create" do
    before do
      Speaker.stub(:create).with('name' => 'VarnaConf').and_return speaker
    end

    it "creates a new speaker" do
      Speaker.should_receive(:create).with('name' => 'VarnaConf').and_return speaker
      post :create, speaker: {name: 'VarnaConf'}
    end

    it "assigns the new speaker" do
      post :create, speaker: {name: 'VarnaConf'}
      expect(assigns[:speaker]).to eq speaker
    end

    it "responds with the new speaker" do
      controller.should_receive(:respond_with).with speaker, location: admin_speakers_path
      post :create, speaker: {name: 'VarnaConf'}
    end
  end

  describe "GET show" do
    it "assigns the speaker" do
      Speaker.stub(:find).with('1').and_return speaker
      get :show, id: '1'
      expect(assigns[:speaker]).to eq speaker
    end
  end


  describe "GET edit" do
    it "assigns the speaker" do
      Speaker.stub(:find).with('1').and_return speaker
      get :edit, id: '1'
      expect(assigns[:speaker]).to eq speaker
    end
  end

  describe "PATCH update" do
    before do
      Speaker.stub(:update).with('1', 'name' => 'VarnaConf').and_return speaker
    end

    it "updates the speaker" do
      Speaker.should_receive(:update).with('1', 'name' => 'VarnaConf').and_return speaker
      patch :update, id: '1', speaker: {name: 'VarnaConf'}
    end

    it "assigns the speaker" do
      patch :update, id: '1', speaker: {name: 'VarnaConf'}
      expect(assigns[:speaker]).to eq speaker
    end

    it "responds with the speaker" do
      controller.should_receive(:respond_with).with speaker, location: admin_speakers_path
      patch :update, id: '1', speaker: {name: 'VarnaConf'}
    end
  end

  describe "DELETE destroy" do
    before do
      Speaker.stub destroy: speaker
    end

    it "removes the speaker" do
      Speaker.should_receive(:destroy).with('1')
      delete :destroy, id: '1'
    end

    it "redirects to speakers list" do
      controller.should_receive(:respond_with).with speaker, location: admin_speakers_path
      delete :destroy, id: '1'
    end
  end
end
