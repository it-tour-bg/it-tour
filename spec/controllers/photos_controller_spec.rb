require 'spec_helper'

describe PhotosController do
  set_current_conference

  let(:event) { double 'event' }

  describe "GET 'index'" do
    let(:photos) { double 'photos' }

    before do
      allow(current_conference).to receive(:announced_event_named).with('2012').and_return event
      allow(event).to receive(:photos).and_return double(ordered: photos)
    end

    it "assigns event" do
      get :index, year: '2012'

      expect(assigns[:event]).to eq event
    end

    it "assigns photos of event" do
      get :index, year: '2012'

      expect(assigns[:photos]).to eq photos
    end
  end
end
