require "application_responder"

class ApplicationController < ActionController::Base
  include CurrentConferenceMethods

  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  respond_to :html

  self.responder = ApplicationResponder

  before_filter :set_locale

  # TODO: remove when the all sites are public
  if Rails.env.production?
    before_filter :hide_non_public_confernecs
  end

  private

  def hide_non_public_confernecs
    return if request.domain == 'varnaconf.com'
    authenticate_or_request_with_http_basic do |name, password|
      name == 'ITTour' && password == 'starts!'
    end
  end

  def set_locale
    I18n.locale = :bg
  end
end
