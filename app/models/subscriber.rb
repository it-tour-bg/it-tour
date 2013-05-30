class Subscriber < ActiveRecord::Base
  belongs_to :conference

  validates :email,
      presence:   true,
      email:      true,
      uniqueness: {scope: :conference_id}

  default_scope { order 'id DESC' }

  scope :active, -> { where active: true }
  scope :for_conference, ->(id) {  where conference_id: id }

  class << self
    def filter(params = {})
      scope = all
      scope = scope.for_conference(params[:conference_id]) unless params[:conference_id].blank?
      scope = scope.active unless params[:active].blank?
      scope
    end
  end

  def error_message
    errors.full_messages.first
  end

  def conference_name
    conference ? conference.name : ""
  end
end
