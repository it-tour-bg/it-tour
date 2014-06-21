require 'spec_helper'

describe EventsController do
  set_current_conference

  let(:event) { double 'event' }

  describe "GET show" do
    before do
      allow(event).to receive(:current?)
      allow(current_conference).to receive(:announced_event_named).with('2012').and_return event
    end

    it "assign a finished conference event for given domain for year" do
      get :show, year: '2012'
      expect(assigns[:event]).to eq event
    end

    it "decorates the event" do
      get :show, year: '2012'
      expect(assigns[:event]).to be_decorated
    end

    it "renders show action if event is not current" do
      allow(event).to receive(:current?).and_return false
      get :show, year: '2012'
      expect(controller).to render :show
    end

    it "redirects to root if event is current" do
      allow(event).to receive(:current?).and_return true
      get :show, year: '2012'
      expect(controller).to redirect_to root_path
    end
  end
end
