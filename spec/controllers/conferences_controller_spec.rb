require 'spec_helper'

describe ConferencesController do
  set_current_conference

  describe "#show" do
    context "regular conference" do
      before do
        current_conference.stub current_event: 'event', main?: false
        EventDecorator.stub(:decorate).with('event') { 'decorated event' }
      end

      it "assigns decorated event" do
        get :show
        expect(assigns[:event]).to eq 'decorated event'
      end

      it "renders 'event/show' action" do
        get :show
        expect(controller).to render_template 'events/show'
      end
    end

    context "main conference" do
      before do
        current_conference.stub main?: true
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
        expect(controller).to render_template 'conferences/show'
      end
    end
  end
end
