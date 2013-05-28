class AddTwitterToSpeakers < ActiveRecord::Migration
  def change
    add_column :speakers, :twitter_account, :string
  end
end
