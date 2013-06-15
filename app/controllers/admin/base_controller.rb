class Admin::BaseController < ApplicationController
  include CurrentUserMethods

  layout 'admin'

  respond_to :html

  private

  def set_locale
    I18n.locale = :en
  end

end
