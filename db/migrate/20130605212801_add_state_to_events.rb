class AddStateToEvents < ActiveRecord::Migration
  def change
    add_column :events, :state, :string, default: 'future', null: false
  end
end
