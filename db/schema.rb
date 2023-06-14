# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[7.0].define(version: 2023_06_09_010935) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "pgcrypto"
  enable_extension "plpgsql"

  create_table "admins", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "username", default: "", null: false
    t.uuid "api_key", default: -> { "gen_random_uuid()" }, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["api_key"], name: "index_admins_on_api_key", unique: true
    t.index ["username"], name: "index_admins_on_username", unique: true
  end

  create_table "events", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.jsonb "data", default: {}
    t.string "tags", default: [], array: true
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["tags"], name: "index_events_on_tags"
  end

  create_table "messages", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "message_status", default: "", null: false
    t.string "remote_id", default: ""
    t.uuid "phone_number_id", null: false
    t.string "body", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["phone_number_id"], name: "index_messages_on_phone_number_id"
    t.index ["remote_id"], name: "index_messages_on_remote_id", unique: true
  end

  create_table "phone_numbers", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "number_status", default: "", null: false
    t.string "phone_number", default: "", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["phone_number"], name: "index_phone_numbers_on_phone_number", unique: true
  end

end
