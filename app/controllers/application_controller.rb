require "application_responder"

class ApplicationController < ActionController::Base
  include CurrentConferenceMethods

  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  respond_to :html

  self.responder = ApplicationResponder

  before_filter :set_locale

  private

  def set_locale
    I18n.locale = :bg
  end
end
