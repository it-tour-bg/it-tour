class CreatePhotos < ActiveRecord::Migration
  def change
    create_table :photos do |t|
      t.integer :event_id, null: false
      t.foreign_key :events
      t.integer :position, null: false
      t.string :asset, null: false
      t.timestamps
    end
  end
end
