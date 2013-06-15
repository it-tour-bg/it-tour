require "application_responder"

class ApplicationController < ActionController::Base
  include CurrentConferenceMethods

  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  respond_to :html

  self.responder = ApplicationResponder

  before_filter :set_locale

  # TODO: remove when the site goes public
  if Rails.env.production?
    http_basic_authenticate_with name: 'ITTour', password: 'starts!'
  end

  private

  def set_locale
    I18n.locale = :bg
  end
end
