class AddAnnouncementsToEvevents < ActiveRecord::Migration
  def change
    add_column :events, :dates_announced, :boolean, default: false
    add_column :events, :venue_announced, :boolean, default: false
    add_column :events, :after_party_announced, :boolean, default: false
    add_column :events, :sessions_announced, :boolean, default: false
    add_column :events, :speakers_announced, :boolean, default: false
  end
end
