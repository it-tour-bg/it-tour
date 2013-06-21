module CurrentConferenceMethods
  extend ActiveSupport::Concern

  included do
    helper_method :current_conference
  end

  private

  def current_conference
    @current_conference ||= begin
      domain = request.domain
      domain = params[:domain] || 'example.com' if Rails.env.development?
      Conference.find_for_domain(domain)
    end
  end
end
