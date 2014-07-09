module SpecSupport
  module Features
    module ConferenceEvent
      def create_dummy_conference_event
        before do
          create :event, conference: create(:conference, domain: 'example.com')
        end
      end
    end
  end
end
