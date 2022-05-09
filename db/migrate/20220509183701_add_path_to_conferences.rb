class AddPathToConferences < ActiveRecord::Migration
  def change
    add_column :conferences, :path, :text, default: '', null: true
  end
end
