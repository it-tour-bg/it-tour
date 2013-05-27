class AddAfterPartyVenueToEvents < ActiveRecord::Migration
  def change
    add_column :events, :after_party_venue_name, :string
    add_column :events, :after_party_venue_site_url, :string
    add_column :events, :after_party_venue_address, :string
    add_column :events, :after_party_venue_notes, :string
    add_column :events, :after_party_venue_map_url, :text
    add_column :events, :after_party_venue_map_image_url, :text
  end
end
