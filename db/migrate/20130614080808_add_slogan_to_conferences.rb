class AddSloganToConferences < ActiveRecord::Migration
  def change
    add_column :conferences, :slogan, :string
  end
end
