class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.references :conference
      t.foreign_key :conferences

      t.string :name, null: false
      t.date :date, null: false
      t.boolean :publicly_announced, null: false, default: false
      t.string :facebook_event_url
      t.string :venue_name
      t.string :venue_site_url
      t.string :venue_address
      t.string :venue_google_map_url
      t.string :venue_google_map_image_url
      t.string :venue_notes

      t.timestamps null: true
    end
  end
end
