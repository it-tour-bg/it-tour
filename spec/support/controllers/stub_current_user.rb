module SpecSupport
  module Controllers
    module StubCurrentUser
      def stub_current_user
        before do
          user = block_given? ? yield : double('current user')
          controller.stub current_user: user
        end
      end
    end
  end
end
