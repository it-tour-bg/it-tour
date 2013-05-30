class Subscriber < ActiveRecord::Base
  belongs_to :conference

  validates :email,
      presence:   true,
      email:      true,
      uniqueness: {scope: :conference_id}

  default_scope { order 'id DESC' }

  def error_message
    errors.full_messages.first
  end
end
