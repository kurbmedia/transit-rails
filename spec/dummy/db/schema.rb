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

ActiveRecord::Schema.define(version: 2022_01_27_035452) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "transit_medias", force: :cascade do |t|
    t.string "name"
    t.string "file_name"
    t.string "content_type", default: ""
    t.integer "file_size", default: 0
    t.string "fingerprint"
    t.string "media_type"
    t.string "attachable_type"
    t.bigint "attachable_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["attachable_type", "attachable_id"], name: "index_transit_medias_on_attachable_type_and_attachable_id"
  end

  create_table "transit_menu_items", force: :cascade do |t|
    t.string "title"
    t.string "url"
    t.string "target"
    t.string "ancestry"
    t.integer "ancestry_depth"
    t.bigint "menu_id"
    t.bigint "page_id"
    t.integer "position"
    t.string "uid"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["menu_id"], name: "index_transit_menu_items_on_menu_id"
    t.index ["page_id"], name: "index_transit_menu_items_on_page_id"
  end

  create_table "transit_menus", force: :cascade do |t|
    t.string "name"
    t.string "identifier"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["identifier"], name: "index_transit_menus_on_identifier", unique: true
  end

  create_table "transit_pages", force: :cascade do |t|
    t.string "name"
    t.string "title"
    t.text "description"
    t.text "keywords"
    t.string "slug"
    t.string "full_path"
    t.string "identifier"
    t.json "region_data", default: {}
    t.json "region_draft", default: {}
    t.string "ancestry"
    t.integer "ancestry_depth"
    t.boolean "published", default: false
    t.datetime "publish_on"
    t.boolean "editable", default: true
    t.integer "position"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["full_path"], name: "index_transit_pages_on_full_path"
    t.index ["identifier"], name: "index_transit_pages_on_identifier", unique: true
    t.index ["slug"], name: "index_transit_pages_on_slug"
  end

  create_table "transit_settings", force: :cascade do |t|
    t.string "key"
    t.text "value"
    t.string "value_type"
    t.text "options"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

end
