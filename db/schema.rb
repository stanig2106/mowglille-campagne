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

ActiveRecord::Schema[7.0].define(version: 2024_03_07_003552) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "active_storage_attachments", force: :cascade do |t|
    t.string "name", null: false
    t.string "record_type", null: false
    t.bigint "record_id", null: false
    t.bigint "blob_id", null: false
    t.datetime "created_at", null: false
    t.index ["blob_id"], name: "index_active_storage_attachments_on_blob_id"
    t.index ["record_type", "record_id", "name", "blob_id"], name: "index_active_storage_attachments_uniqueness", unique: true
  end

  create_table "active_storage_blobs", force: :cascade do |t|
    t.string "key", null: false
    t.string "filename", null: false
    t.string "content_type"
    t.text "metadata"
    t.string "service_name", null: false
    t.bigint "byte_size", null: false
    t.string "checksum"
    t.datetime "created_at", null: false
    t.index ["key"], name: "index_active_storage_blobs_on_key", unique: true
  end

  create_table "active_storage_variant_records", force: :cascade do |t|
    t.bigint "blob_id", null: false
    t.string "variation_digest", null: false
    t.index ["blob_id", "variation_digest"], name: "index_active_storage_variant_records_uniqueness", unique: true
  end

  create_table "activities", force: :cascade do |t|
    t.string "internal_id"
    t.string "name"
    t.text "description"
    t.datetime "start_date"
    t.datetime "end_date"
    t.string "location"
    t.bigint "event_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.text "internal_description"
    t.index ["event_id"], name: "index_activities_on_event_id"
  end

  create_table "activity_rewards", force: :cascade do |t|
    t.bigint "activity_id", null: false
    t.integer "score"
    t.string "chest"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.text "internal_description"
    t.string "name"
    t.index ["activity_id"], name: "index_activity_rewards_on_activity_id"
  end

  create_table "challenges", force: :cascade do |t|
    t.string "name"
    t.text "description"
    t.integer "score"
    t.datetime "start_date"
    t.datetime "end_date"
    t.integer "amount"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "category"
    t.boolean "is_flash"
  end

  create_table "chests", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.string "type"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_chests_on_user_id"
  end

  create_table "cla_infos", force: :cascade do |t|
    t.string "username"
    t.string "first_name"
    t.string "last_name"
    t.string "school_email"
    t.string "cursus"
    t.string "promo"
  end

  create_table "collection_pieces", force: :cascade do |t|
    t.integer "number"
    t.string "name"
    t.string "rarity"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "collections", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "collection_piece_id", null: false
    t.datetime "date"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["collection_piece_id"], name: "index_collections_on_collection_piece_id"
    t.index ["user_id"], name: "index_collections_on_user_id"
  end

  create_table "congratulations", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.string "reason"
    t.bigint "target_id", null: false
    t.index ["target_id"], name: "index_congratulations_on_target_id"
    t.index ["user_id"], name: "index_congratulations_on_user_id"
  end

  create_table "events", force: :cascade do |t|
    t.string "internal_id"
    t.string "name"
    t.string "type"
    t.datetime "start_date"
    t.datetime "end_date"
    t.string "location"
    t.text "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "game_scores", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.string "game_name", null: false
    t.float "score", null: false
    t.boolean "pb", default: false, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_game_scores_on_user_id"
  end

  create_table "menu_items", force: :cascade do |t|
    t.string "name"
    t.string "type"
    t.boolean "vg"
    t.string "src"
    t.bigint "event_id", null: false
    t.index ["event_id"], name: "index_menu_items_on_event_id"
  end

  create_table "planning_urls", force: :cascade do |t|
    t.string "url"
  end

  create_table "qr_codes", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.string "token"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "count", default: 0
    t.boolean "offline", default: false
    t.index ["user_id"], name: "index_qr_codes_on_user_id"
  end

  create_table "rewards", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "activity_reward_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["activity_reward_id"], name: "index_rewards_on_activity_reward_id"
    t.index ["user_id"], name: "index_rewards_on_user_id"
  end

  create_table "score_records", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "challenge_id"
    t.bigint "activity_id"
    t.integer "score"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "reason"
    t.bigint "offered_by_id"
    t.index ["activity_id"], name: "index_score_records_on_activity_id"
    t.index ["challenge_id"], name: "index_score_records_on_challenge_id"
    t.index ["offered_by_id"], name: "index_score_records_on_offered_by_id"
    t.index ["user_id"], name: "index_score_records_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "token"
    t.string "public_token"
    t.bigint "cla_info_id"
    t.string "staff_roles", default: [], array: true
    t.string "planning_letter"
    t.jsonb "subscription"
    t.string "notification_preferences", array: true
    t.boolean "collection_winner", default: false
    t.index ["cla_info_id"], name: "index_users_on_cla_info_id"
  end

  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
  add_foreign_key "active_storage_variant_records", "active_storage_blobs", column: "blob_id"
  add_foreign_key "activities", "events"
  add_foreign_key "activity_rewards", "activities"
  add_foreign_key "chests", "users"
  add_foreign_key "collections", "collection_pieces"
  add_foreign_key "collections", "users"
  add_foreign_key "congratulations", "users"
  add_foreign_key "congratulations", "users", column: "target_id"
  add_foreign_key "game_scores", "users"
  add_foreign_key "menu_items", "events"
  add_foreign_key "qr_codes", "users"
  add_foreign_key "rewards", "activity_rewards"
  add_foreign_key "rewards", "users"
  add_foreign_key "score_records", "activities"
  add_foreign_key "score_records", "challenges"
  add_foreign_key "score_records", "users"
  add_foreign_key "score_records", "users", column: "offered_by_id"
  add_foreign_key "users", "cla_infos"
end
