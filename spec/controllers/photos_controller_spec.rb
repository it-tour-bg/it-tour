require 'spec_helper'

describe PhotosController do
  let(:event) { double 'event' }
  let(:conference) { double 'conference' }

  before do
    allow(Conference).to receive(:find_for_domain).with('exampleconf.com').and_return conference
    request.host = 'exampleconf.com'
  end

  describe "GET 'index'" do
    let(:photos) { double ordered: 'photos' }

    before do
      allow(conference).to receive(:announced_event_named).with('2012').and_return event
      allow(event).to receive(:photos).and_return photos
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
