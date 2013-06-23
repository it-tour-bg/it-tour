class ReplaceEventStateWithCurrent < ActiveRecord::Migration
  def change
    add_column :events, :current, :boolean, default: false, null: false
    execute "UPDATE events SET current='t' WHERE state='current'"
    remove_column :events, :state
  end
end
