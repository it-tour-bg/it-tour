module SpecSupport
  module Controllers
    module RespondWith
      def self.included(base)
        base.before do
          controller.stub respond_with: nil
          controller.stub render: ''
        end
      end

      def respond_with(object, options = nil)
        if options
          have_received(:respond_with).with object, options
        else
          have_received(:respond_with).with object
        end
      end
    end
  end
end
