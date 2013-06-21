module CurrentConferenceMethods
  extend ActiveSupport::Concern

  included do
    helper_method :current_conference
  end

  private

  def current_conference
    @current_conference ||= begin
      domain = request.domain || params[:domain] || 'varnaconf.com' # TODO remove when site goes public
      Conference.find_for_domain(domain)
    end
  end
end
