module SpecSupport
  module Controllers
    module StubRendering
      def self.included(base)
        base.extend ClassMethods
      end

      def stub_rendering
        allow(controller).to receive(:render).and_return ''
      end

      module ClassMethods
        def stub_rendering
          before { stub_rendering }
        end
      end
    end
  end
end

