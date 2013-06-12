require 'spec_helper'

describe EventsController do
  let(:event) { double 'event' }
  let(:conference) { double 'conference' }

  before do
    Conference.stub(:find_for_domain).with('varnaconf.com').and_return conference
    request.host = 'varnaconf.com'
  end

  describe "GET index" do
    it "assign the current conference event for given domain" do
      conference.stub current_event: event
      get :index
      expect(assigns[:event]).to eq event
    end

    it "renders show action" do
      conference.stub current_event: event
      get :index
      expect(controller).to render_template :show
    end
  end

  describe "GET show" do
    it "assign a finished conference event for given domain for year" do
      conference.stub(:finished_event_named).with('2012').and_return event
      get :show, year: '2012'
      expect(assigns[:event]).to eq event
    end
  end
end
