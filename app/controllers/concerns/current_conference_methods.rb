module CurrentConferenceMethods
  extend ActiveSupport::Concern

  included do
    helper_method :current_conference
  end

  private

  def current_conference
    @current_conference ||= begin
      domain = request.domain
      path = request.path
      domain = params[:domain] || 'varnaconf.com' if Rails.env.development?
      Conference.find_for_domain(domain, path)
    end
  end
end
