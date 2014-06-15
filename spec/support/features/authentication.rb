module SpecSupport
  module Features
    module Authentication
      extend ActiveSupport::Concern

      def current_user
        @current_user
      end

      def sign_in(user = nil)
        @current_user = user || create(:user)
        visit "/backdoor/login?email=#{CGI.escape(@current_user.email)}"
      end

      module ClassMethods
        def sign_in
          before { sign_in }
        end
      end
    end
  end
end
