module SpecSupport
  module Controllers
    module RespondWith
      def self.included(base)
        base.before do
          allow(controller).to receive(:respond_with).and_return nil
          allow(controller).to receive(:render).and_return ''
        end
      end

      def respond_with(object, options = nil)
        if options
          have_received(:respond_with).with object, options
        else
          have_received(:respond_with).with object
        end
      end

      def render(*args)
        if args.any?
          have_received(:render).with *args
        else
          have_received(:render)
        end
      end
    end
  end
end
