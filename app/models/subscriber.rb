class Subscriber < ActiveRecord::Base
  belongs_to :conference

  validates :email,
      presence:   true,
      uniqueness: {scope: :conference_id},
      format:     /\A[A-Z0-9_\.%\+\-\']+@(?:[A-Z0-9\-]+\.)+(?:[A-Z]{2,4}|museum|travel)\z/i

  default_scope { order 'id DESC' }
end
