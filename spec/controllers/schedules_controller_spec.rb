require 'spec_helper'

describe SchedulesController do
  stub_current_conference

  let(:event) { double name: '2015' }

  describe "GET 'index'" do
    it 'redirects to current event schedule' do
      allow(current_conference).to receive(:current_event).and_return event

      get :index

      expect(controller).to redirect_to schedule_path(event.name, format: 'json')
    end
  end

  describe "GET 'show'" do
    before do
      allow(current_conference).to receive(:announced_event_named).with(event.name).and_return event
    end

    it 'assigns event' do
      get :show, id: event.name

      expect(assigns[:event]).to eq event
    end

    it 'assigns track number' do
      get :show, id: event.name, track: '1'

      expect(assigns[:track]).to eq 1
    end
  end
end
