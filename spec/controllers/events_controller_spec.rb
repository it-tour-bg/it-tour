require 'spec_helper'

describe EventsController do
  let(:event) { double 'event' }
  let(:conference) { double 'conference' }

  before do
    Conference.stub(:find_for_domain).with('exampleconf.com').and_return conference
    request.host = 'exampleconf.com'
  end

  describe "GET index" do
    it "assign the current conference event for given domain" do
      conference.stub current_event: event
      get :index
      expect(assigns[:event]).to eq event
    end

    it "decorates the event" do
      conference.stub current_event: event
      get :index
      expect(assigns[:event]).to be_decorated
    end

    it "renders show action" do
      conference.stub current_event: event
      get :index
      expect(controller).to render_template :show
    end
  end

  describe "GET show" do
    before do
      event.stub :current?
      conference.stub(:announced_event_named).with('2012').and_return event
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
      event.stub current?: false
      get :show, year: '2012'
      expect(controller).to render_template :show
    end

    it "redirects to root if event is current" do
      event.stub current?: true
      get :show, year: '2012'
      expect(controller).to redirect_to root_path
    end
  end
end
