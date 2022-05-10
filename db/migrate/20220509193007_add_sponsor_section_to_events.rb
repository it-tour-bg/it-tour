class AddSponsorSectionToEvents < ActiveRecord::Migration
  def change
    add_column :events, :sponsor_embed, :text
    add_column :events, :show_sponsor_embed, :boolean, :default => false, :null => false
  end
end
