require 'spec_helper'

describe Admin::PhotosController do
  stub_current_user

  describe "GET 'index'" do
    it "assigns an event" do
      Event.stub(:find).with('1').and_return 'event'
      get :index, event_id: 1
      expect(assigns[:event]).to eq 'event'
    end
  end

  describe "POST create" do
    let(:photo) { {id: 1} }

    before do
      Photo.stub create!: photo
    end

    it "creates a new photo" do
      Photo.should_receive(:create!).with(event_id: '1', asset: 'file').and_return photo
      post :create, event_id: '1', file: 'file'
    end

    it "renders photo in json format" do
      post :create
      expect(response.body).to eq photo.to_json
    end
  end

  describe "DELETE 'destroy'" do
    it "removes a photo" do
      Photo.should_receive(:destroy).with('1')
      delete :destroy, id: '1'
    end
  end
end
