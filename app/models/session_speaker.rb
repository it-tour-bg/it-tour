class SessionSpeaker < ActiveRecord::Base
  belongs_to :speaker
  belongs_to :session

  validates :speaker, presence: true
  validates :session, presence: true
  validates :speaker_id, uniqueness: {scope: :session_id}
end
