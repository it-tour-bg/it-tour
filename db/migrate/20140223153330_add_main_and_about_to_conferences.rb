class AddMainAndAboutToConferences < ActiveRecord::Migration
  def change
    change_table :conferences, bulk: true do |t|
      t.boolean :main, default: false, null: false
      t.text :about
      t.index :main
    end
  end
end
