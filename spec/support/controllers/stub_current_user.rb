module SpecSupport
  module Controllers
    module StubCurrentUser
      def stub_current_user
        attr_reader :current_user

        before do
          @current_user = block_given? ? yield : double('current user')
          allow(controller).to receive(:current_user).and_return @current_user
        end
      end
    end
  end
end
