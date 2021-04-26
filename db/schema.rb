# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `rails
# db:schema:load`. When creating a new database, `rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2021_04_26_085509) do

  create_table "active_storage_attachments", force: :cascade do |t|
    t.string "name", null: false
    t.string "record_type", null: false
    t.integer "record_id", null: false
    t.integer "blob_id", null: false
    t.datetime "created_at", null: false
    t.index ["blob_id"], name: "index_active_storage_attachments_on_blob_id"
    t.index ["record_type", "record_id", "name", "blob_id"], name: "index_active_storage_attachments_uniqueness", unique: true
  end

  create_table "active_storage_blobs", force: :cascade do |t|
    t.string "key", null: false
    t.string "filename", null: false
    t.string "content_type"
    t.text "metadata"
    t.bigint "byte_size", null: false
    t.string "checksum", null: false
    t.datetime "created_at", null: false
    t.index ["key"], name: "index_active_storage_blobs_on_key", unique: true
  end

  create_table "artists", force: :cascade do |t|
    t.string "name"
    t.text "info"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "comments", force: :cascade do |t|
    t.integer "dance_id"
    t.integer "music_id"
    t.integer "stage_id"
    t.text "content"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["dance_id"], name: "index_comments_on_dance_id"
    t.index ["music_id"], name: "index_comments_on_music_id"
    t.index ["stage_id"], name: "index_comments_on_stage_id"
  end

  create_table "dances", force: :cascade do |t|
    t.string "name"
    t.text "info"
    t.date "date"
    t.string "youtube_url"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "list_maps", force: :cascade do |t|
    t.integer "list_id"
    t.integer "dance_id"
    t.integer "music_id"
    t.integer "stage_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["dance_id"], name: "index_list_maps_on_dance_id"
    t.index ["list_id"], name: "index_list_maps_on_list_id"
    t.index ["music_id"], name: "index_list_maps_on_music_id"
    t.index ["stage_id"], name: "index_list_maps_on_stage_id"
  end

  create_table "lists", force: :cascade do |t|
    t.string "list_name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "musics", force: :cascade do |t|
    t.string "name"
    t.text "info"
    t.date "date"
    t.string "youtube_url"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "stage_artists", force: :cascade do |t|
    t.integer "stage_id", null: false
    t.integer "artist_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["artist_id"], name: "index_stage_artists_on_artist_id"
    t.index ["stage_id"], name: "index_stage_artists_on_stage_id"
  end

  create_table "stages", force: :cascade do |t|
    t.string "name"
    t.text "info"
    t.date "from_date"
    t.date "until_date"
    t.string "place"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "tag_maps", force: :cascade do |t|
    t.integer "dance_id"
    t.integer "music_id"
    t.integer "stage_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "tag_id"
    t.index ["dance_id"], name: "index_tag_maps_on_dance_id"
    t.index ["music_id"], name: "index_tag_maps_on_music_id"
    t.index ["stage_id"], name: "index_tag_maps_on_stage_id"
    t.index ["tag_id"], name: "index_tag_maps_on_tag_id"
  end

  create_table "tags", force: :cascade do |t|
    t.string "tag_name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "users", force: :cascade do |t|
    t.string "name"
    t.string "password_digest"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "remember_digest"
  end

  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
  add_foreign_key "list_maps", "dances"
  add_foreign_key "list_maps", "musics"
  add_foreign_key "list_maps", "stages"
  add_foreign_key "list_maps", "tags", column: "list_id"
  add_foreign_key "stage_artists", "artists"
  add_foreign_key "stage_artists", "stages"
  add_foreign_key "tag_maps", "dances"
  add_foreign_key "tag_maps", "musics"
  add_foreign_key "tag_maps", "stages"
end
