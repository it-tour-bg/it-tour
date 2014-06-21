module SpecSupport
  module Controllers
    module StubCurrentConference
      def set_current_conference
        current_conference { double 'Current conference'}
      end

      def current_conference(&block)
        let :current_conference, &block

        before do
          allow(controller).to receive(:current_conference).and_return current_conference
        end
      end
    end
  end
end
