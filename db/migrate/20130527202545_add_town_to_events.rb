class AddTownToEvents < ActiveRecord::Migration
  def change
    add_column :events, :town, :string
  end
end
