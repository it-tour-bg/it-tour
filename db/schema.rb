# encoding: UTF-8
# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20140708211216) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "conferences", force: true do |t|
    t.string   "name"
    t.string   "contact_name"
    t.string   "contact_email"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "facebook_account"
    t.string   "twitter_account"
    t.string   "youtube_account"
    t.string   "domain"
    t.string   "slogan"
    t.boolean  "main",             default: false, null: false
    t.text     "about"
  end

  add_index "conferences", ["main"], name: "index_conferences_on_main", using: :btree

  create_table "events", force: true do |t|
    t.integer  "conference_id"
    t.string   "name",                                       null: false
    t.date     "date",                                       null: false
    t.boolean  "publicly_announced",         default: false, null: false
    t.string   "event_url"
    t.string   "venue_name"
    t.string   "venue_site_url"
    t.string   "venue_address"
    t.string   "venue_map_url"
    t.text     "venue_notes"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "after_party_venue_name"
    t.string   "after_party_venue_site_url"
    t.string   "after_party_venue_address"
    t.string   "after_party_venue_notes"
    t.text     "after_party_venue_map_url"
    t.string   "town"
    t.text     "notes"
    t.boolean  "dates_announced",            default: false
    t.boolean  "venue_announced",            default: false
    t.boolean  "after_party_announced",      default: false
    t.boolean  "sessions_announced",         default: false
    t.boolean  "speakers_announced",         default: false
    t.string   "logo"
    t.string   "coverart"
    t.boolean  "current",                    default: false, null: false
    t.boolean  "show_feedback_form",         default: false, null: false
    t.boolean  "show_photo_gallery",         default: false, null: false
    t.text     "streaming_code"
    t.boolean  "show_streaming",             default: false, null: false
    t.boolean  "show_coverart",              default: false, null: false
    t.string   "color"
    t.string   "call_to_papers_url"
  end

  create_table "feedbacks", force: true do |t|
    t.integer  "event_id",   null: false
    t.text     "comment",    null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "photos", force: true do |t|
    t.integer  "event_id",   null: false
    t.integer  "position",   null: false
    t.string   "asset",      null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "session_speakers", force: true do |t|
    t.integer  "speaker_id", null: false
    t.integer  "session_id", null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "session_speakers", ["speaker_id", "session_id"], name: "index_session_speakers_on_speaker_id_and_session_id", unique: true, using: :btree

  create_table "sessions", force: true do |t|
    t.integer  "event_id",   null: false
    t.string   "start_at",   null: false
    t.string   "title",      null: false
    t.string   "slides_url"
    t.string   "video_url"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "speakers", force: true do |t|
    t.string   "name",             null: false
    t.text     "description"
    t.string   "personal_site"
    t.string   "company"
    t.string   "company_site"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "twitter_account"
    t.string   "photo"
    t.string   "tshirt_size"
    t.string   "github_account"
    t.string   "facebook_account"
    t.string   "dribbble_account"
  end

  create_table "subscribers", force: true do |t|
    t.integer  "conference_id"
    t.string   "email",                        null: false
    t.boolean  "active",        default: true, null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", force: true do |t|
    t.string   "first_name",                   null: false
    t.string   "last_name",                    null: false
    t.string   "email",           default: "", null: false
    t.string   "password_digest", default: "", null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree

  add_foreign_key "events", "conferences", name: "events_conference_id_fk"

  add_foreign_key "feedbacks", "events", name: "feedbacks_event_id_fk"

  add_foreign_key "photos", "events", name: "photos_event_id_fk"

  add_foreign_key "session_speakers", "sessions", name: "session_speakers_session_id_fk"
  add_foreign_key "session_speakers", "speakers", name: "session_speakers_speaker_id_fk"

  add_foreign_key "sessions", "events", name: "sessions_event_id_fk"

  add_foreign_key "subscribers", "conferences", name: "subscribers_conference_id_fk"

end
