class AddTShirtSizeToSpeakers < ActiveRecord::Migration
  def change
    add_column :speakers, :tshirt_size, :string
  end
end
