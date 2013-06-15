module CurrentConferenceMethods
  extend ActiveSupport::Concern

  included do
    helper_method :current_conference
  end

  private

  def current_conference
    @current_conference ||= Conference.find_for_domain('varnaconf.com')#request.domain)
  end
end
