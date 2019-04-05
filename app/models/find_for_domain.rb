module FindForDomain
  extend self

  def call(domain, path)
    find_by_domain_and_path(domain, path) || find_by_domain(domain)
  end

  private

  def find_by_domain_and_path(domain, path)
    return nil if path.blank?

    segment = path.sub(/\A\//m, '').split('/').first

    return nil if segment.blank?

    Conference.where(domain: "#{domain}/#{segment}").first
  end

  def find_by_domain(domain)
    Conference.where(domain: domain).first!
  end
end
