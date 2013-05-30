require 'csv'

CSV.generate do |out|
  out << %w(email conference active token)
  @subscribers.find_each do |subscriber|
    out << [subscriber.email, subscriber.conference_name.presence || 'All', subscriber.active ? 'Yes' : 'No', EmailToken.for(subscriber)]
  end
end.strip
