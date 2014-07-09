class AllowMoreThanOneSpeakerPerSession < ActiveRecord::Migration
  def up
    create_table :session_speakers do |t|
      t.integer :speaker_id, null: false
      t.foreign_key :speakers
      t.integer :session_id, null: false
      t.foreign_key :sessions
      t.timestamps
    end

    add_index :session_speakers, [:speaker_id, :session_id], unique: true

    execute("SELECT id, speaker_id FROM sessions WHERE speaker_id IS NOT NULL").each do |row|
      execute "INSERT INTO session_speakers (session_id, speaker_id) VALUES ('#{row['id']}', '#{row['speaker_id']}')"
    end

    remove_column :sessions, :speaker_id
  end

  def down
    add_column :sessions, :speaker_id, :integer
    add_foreign_key :sessions, :speakers

    execute("SELECT session_id, speaker_id FROM session_speakers").each do |row|
      execute "UPDATE sessions SET speaker_id = '#{row['speaker_id']}' WHERE id = '#{row['session_id']}'"
    end

    drop_table :session_speakers
  end
end
