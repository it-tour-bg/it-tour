require 'spec_helper'

describe Admin::EventNotesController do
  stub_current_user
  stub_rendering

  let(:event) { double :event }

  describe "GET edit" do
    it "assigns the event" do
      Event.stub(:find).with('1').and_return event
      get :edit, event_id: '1'
      expect(assigns[:event]).to eq event
    end
  end

  describe "PATCH update" do
    before do
      Event.stub(:update).with('1', notes: 'text').and_return event
    end

    it "updates the event" do
      Event.should_receive(:update).with('1', notes: 'text').and_return event
      patch :update, event_id: '1', event: {notes: 'text'}
    end

    it "assigns the event" do
      patch :update, event_id: '1', event: {notes: 'text'}
      expect(assigns[:event]).to eq event
    end

    it "responds with the event" do
      controller.should_receive(:respond_with).with(event, location: admin_event_path(event, anchor: 'notes'))
      patch :update, event_id: '1', event: {notes: 'text'}
    end
  end
end

