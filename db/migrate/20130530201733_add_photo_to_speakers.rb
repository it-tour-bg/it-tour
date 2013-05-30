class AddPhotoToSpeakers < ActiveRecord::Migration
  def change
    add_column :speakers, :photo, :string
  end
end
