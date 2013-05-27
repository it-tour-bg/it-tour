class RenameEventUrls < ActiveRecord::Migration
  def change
    rename_column :events, :facebook_event_url, :event_url
    rename_column :events, :venue_google_map_url, :venue_map_url
    rename_column :events, :venue_google_map_image_url, :venue_map_image_url
  end
end
