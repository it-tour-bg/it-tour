class AddEmbedUrlToVenues < ActiveRecord::Migration
  def change
    add_column :events, :venue_map_embedded_url, :text
    add_column :events, :after_party_venue_map_embedded_url, :text

    execute 'UPDATE events SET venue_map_embedded_url=venue_map_url, after_party_venue_map_embedded_url=after_party_venue_map_url'
  end
end
