module SpecSupport
  module Controllers
    module StubCurrentUser
      def stub_current_user
        attr_reader :current_user

        before do
          @current_user = block_given? ? yield : double('current user')
          controller.stub current_user: @current_user
        end
      end
    end
  end
end
