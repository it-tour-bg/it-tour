class Admin::BaseController < ApplicationController
  layout 'admin'

  respond_to :html

  helper_method :current_user

  before_filter :require_user


  private

  def set_locale
    I18n.locale = :en
  end

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
