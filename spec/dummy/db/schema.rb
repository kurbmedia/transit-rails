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
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20130801203604) do

  create_table "transit_drafts", :force => true do |t|
    t.integer "draftable_id"
    t.string  "draftable_type"
    t.text    "content"
  end

  create_table "transit_medias", :force => true do |t|
    t.string   "name"
    t.string   "file_name"
    t.string   "content_type",    :default => ""
    t.integer  "file_size",       :default => 0
    t.string   "fingerprint"
    t.string   "media_type"
    t.integer  "attachable_id"
    t.string   "attachable_type"
    t.datetime "created_at",                      :null => false
    t.datetime "updated_at",                      :null => false
  end

  create_table "transit_menu_items", :force => true do |t|
    t.string   "title"
    t.string   "url"
    t.string   "target"
    t.string   "ancestry"
    t.integer  "ancestry_depth"
    t.integer  "menu_id"
    t.integer  "page_id"
    t.integer  "position"
    t.string   "uid"
    t.datetime "created_at",     :null => false
    t.datetime "updated_at",     :null => false
  end

  create_table "transit_menus", :force => true do |t|
    t.string   "name"
    t.string   "identifier"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "transit_menus", ["identifier"], :name => "index_transit_menus_on_identifier", :unique => true

  create_table "transit_pages", :force => true do |t|
    t.string   "name"
    t.string   "title"
    t.text     "description"
    t.text     "keywords"
    t.string   "slug"
    t.string   "full_path"
    t.string   "identifier"
    t.text     "region_data"
    t.string   "draft_state",    :default => "draft"
    t.string   "template",       :default => "default"
    t.string   "ancestry"
    t.integer  "ancestry_depth"
    t.boolean  "published",      :default => false
    t.datetime "publish_on"
    t.boolean  "editable",       :default => true
    t.integer  "position"
    t.datetime "created_at",                            :null => false
    t.datetime "updated_at",                            :null => false
  end

  add_index "transit_pages", ["identifier"], :name => "index_transit_pages_on_identifier", :unique => true

  create_table "transit_settings", :force => true do |t|
    t.string   "key"
    t.text     "value"
    t.string   "value_type"
    t.text     "options"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

end
