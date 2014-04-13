class AddShowCoverartToEvents < ActiveRecord::Migration
  def change
    add_column :events, :show_coverart, :boolean, null: false, default: false
  end
end
