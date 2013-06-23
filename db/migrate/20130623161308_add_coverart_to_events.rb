class AddCoverartToEvents < ActiveRecord::Migration
  def change
    add_column :events, :coverart, :string
  end
end
