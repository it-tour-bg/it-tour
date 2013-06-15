require "application_responder"

class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  respond_to :html

  self.responder = ApplicationResponder

  before_filter :set_locale

  helper_method :current_conference

  private

  def set_locale
    I18n.locale = :bg
  end

  def current_conference
    @current_conference ||= Conference.find_for_domain('varnaconf.com')#request.domain)
  end
end
