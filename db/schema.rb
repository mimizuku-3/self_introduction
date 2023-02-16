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

ActiveRecord::Schema.define(version: 2023_02_08_044252) do

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
    t.string "checksum", null: false
    t.datetime "created_at", null: false
    t.index ["key"], name: "index_active_storage_blobs_on_key", unique: true
  end

  create_table "active_storage_variant_records", force: :cascade do |t|
    t.bigint "blob_id", null: false
    t.string "variation_digest", null: false
    t.index ["blob_id", "variation_digest"], name: "index_active_storage_variant_records_uniqueness", unique: true
  end

  create_table "basic_work_experiences", force: :cascade do |t|
    t.string "affiliation", limit: 150
    t.string "nearest_station", limit: 50
    t.date "date_work_start"
    t.string "carrer_period", limit: 20
    t.boolean "is_married", default: false, null: false
    t.string "strong_field", limit: 200
    t.string "strong_technology", limit: 200
    t.string "strong_business", limit: 200
    t.text "self_promotion"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "introduction_id", null: false
    t.index ["introduction_id"], name: "index_basic_work_experiences_on_introduction_id", unique: true
  end

  create_table "hobbies", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "hobby_name", null: false
  end

  create_table "hobby_introductions", force: :cascade do |t|
    t.bigint "introduction_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "hobby_id", null: false
  end

  create_table "introductions", force: :cascade do |t|
    t.string "name", null: false
    t.integer "age", null: false
    t.string "address", null: false
    t.text "content"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "sex", null: false
    t.integer "prefecture_id", null: false
    t.string "furigana"
  end

  create_table "work_experiences", force: :cascade do |t|
    t.date "start_month", null: false
    t.date "end_month", null: false
    t.string "project_name", limit: 200
    t.text "project_detail"
    t.integer "role", limit: 2
    t.text "role_description"
    t.text "language"
    t.text "database"
    t.text "server"
    t.text "fw_mw_tool_etc"
    t.text "responsible_process"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "introduction_id", null: false
    t.index ["introduction_id"], name: "index_work_experiences_on_introduction_id"
  end

  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
  add_foreign_key "active_storage_variant_records", "active_storage_blobs", column: "blob_id"
end
