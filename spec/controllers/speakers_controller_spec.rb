require 'spec_helper'

describe SpeakersController do
  describe "GET 'show'" do
    it "assigns the selected speaker" do
      Speaker.should_receive(:find).with('1').and_return 'speaker'
      get :show, id: '1'
      expect(assigns[:speaker]).to eq 'speaker'
    end
  end
end
