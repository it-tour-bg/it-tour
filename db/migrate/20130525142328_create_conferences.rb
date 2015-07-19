class CreateConferences < ActiveRecord::Migration
  def change
    create_table :conferences do |t|
      t.string :name
      t.string :contact_name
      t.string :contact_email

      t.timestamps null: true
    end
  end
end
