class AddShowPhotoGalleryToEvents < ActiveRecord::Migration
  def change
    add_column :events, :show_photo_gallery, :boolean, default: false, null: false
  end
end
