class ChangeEventVenueNotesToText < ActiveRecord::Migration
  def change
    change_column :events, :venue_notes, :text
  end
end
