class AddSteamingToEvents < ActiveRecord::Migration
  def change
    add_column :events, :streaming_code, :text
    add_column :events, :show_streaming, :boolean, :default => false, :null => false
  end
end
