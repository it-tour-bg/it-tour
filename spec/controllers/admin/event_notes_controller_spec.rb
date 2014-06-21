require 'spec_helper'

describe Admin::EventNotesController do
  stub_current_user

  let(:event) { double :event }

  describe "GET edit" do
    it "assigns the event" do
      allow(Event).to receive(:find).with('1').and_return event
      get :edit, event_id: '1'
      expect(assigns[:event]).to eq event
    end
  end

  describe "PATCH update" do
    before do
      allow(Event).to receive(:update).with('1', notes: 'text').and_return event
    end

    it "updates the event" do
      patch :update, event_id: '1', event: {notes: 'text'}
      expect(Event).to have_received(:update).with('1', notes: 'text')
    end

    it "assigns the event" do
      patch :update, event_id: '1', event: {notes: 'text'}
      expect(assigns[:event]).to eq event
    end

    it "responds with the event" do
      patch :update, event_id: '1', event: {notes: 'text'}
      expect(controller).to respond_with(event, location: admin_event_path(event, anchor: 'notes'))
    end
  end
end

