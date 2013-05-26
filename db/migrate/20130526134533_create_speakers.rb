class CreateSpeakers < ActiveRecord::Migration
  def change
    create_table :speakers do |t|
      t.string :name, null: false
      t.text :description
      t.string :personal_site
      t.string :company
      t.string :company_site

      t.timestamps
    end
  end
end
