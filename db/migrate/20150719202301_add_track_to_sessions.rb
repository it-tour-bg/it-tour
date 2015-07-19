class AddTrackToSessions < ActiveRecord::Migration
  def change
    add_column :sessions, :track, :integer, default: 1, null: false
  end
end
