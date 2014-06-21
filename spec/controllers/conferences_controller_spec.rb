require 'spec_helper'

describe ConferencesController do
  set_current_conference

  describe "#show" do
    context "regular conference" do
      before do
        allow(current_conference).to receive(:current_event).and_return 'event'
        allow(current_conference).to receive(:main?).and_return false

        allow(EventDecorator).to receive(:decorate).with('event').and_return 'decorated event'
      end

      it "assigns decorated event" do
        get :show
        expect(assigns[:event]).to eq 'decorated event'
      end

      it "renders 'event/show' action" do
        get :show
        expect(controller).to render 'events/show'
      end
    end

    context "main conference" do
      before do
        allow(current_conference).to receive(:main?).and_return true
      end

      it "assigns the current conference as @conference" do
        get :show
        expect(assigns[:conference]).to eq current_conference
      end

      it "doesn't assigns current event" do
        get :show
        expect(assigns[:events]).to be_nil
      end

      it "renders show action" do
        get :show
        expect(controller).to render 'conferences/show'
      end
    end
  end
end
