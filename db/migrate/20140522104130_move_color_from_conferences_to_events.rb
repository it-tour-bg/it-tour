class MoveColorFromConferencesToEvents < ActiveRecord::Migration
  def change
    add_column :events, :color, :string

    execute 'UPDATE events AS e SET color = c.color FROM conferences AS c WHERE c.id = e.conference_id'

    remove_column :conferences, :color, :string
  end
end
