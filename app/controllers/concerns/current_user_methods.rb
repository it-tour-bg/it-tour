module CurrentUserMethods
  extend ActiveSupport::Concern

  included do
    helper_method :current_user

    before_filter :require_user
  end

  private

  def require_user
    if current_user.blank?
      redirect_to sign_in_path
    end
  end

  def current_user
    return @current_user if defined? @current_user
    @current_user = session[:user_id] && User.find(session[:user_id])
  end
end
