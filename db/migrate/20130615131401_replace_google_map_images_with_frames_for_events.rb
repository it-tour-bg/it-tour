class ReplaceGoogleMapImagesWithFramesForEvents < ActiveRecord::Migration
  def change
    remove_column :events, :venue_map_image_url
    remove_column :events, :after_party_venue_map_image_url
  end
end
