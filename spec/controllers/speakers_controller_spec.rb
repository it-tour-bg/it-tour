require 'spec_helper'

describe SpeakersController do
  stub_current_user

  describe "GET 'show'" do
    it "responds with given speaker" do
      allow(Speaker).to receive(:find).with('1').and_return 'speaker'
      allow(SpeakerDecorator).to receive(:decorate).with('speaker').and_return 'decorator'

      get :show, id: '1'

      expect(controller).to respond_with 'decorator'
    end
  end
end
