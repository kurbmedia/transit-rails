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

ActiveRecord::Schema.define(:version => 20130801203610) do

  create_table "transit_pages", :force => true do |t|
    t.string   "name"
    t.string   "title"
    t.text     "description"
    t.text     "keywords"
    t.string   "slug"
    t.string   "identifier"
    t.string   "ancestry"
    t.integer  "ancestry_depth"
    t.text     "slug_map"
    t.text     "content"
    t.text     "content_schema"
    t.boolean  "published",      :default => false
    t.datetime "publish_date"
    t.integer  "position",       :default => 0
    t.datetime "created_at",                        :null => false
    t.datetime "updated_at",                        :null => false
  end

  add_index "pages", ["identifier"], :name => "index_pages_on_identifier", :unique => true

  create_table "transit_posts", :force => true do |t|
    t.string   "title"
    t.text     "teaser"
    t.string   "slug"
    t.text     "content"
    t.text     "content_schema"
    t.boolean  "published",      :default => false
    t.datetime "publish_date"
    t.integer  "position",       :default => 0
    t.datetime "created_at",                        :null => false
    t.datetime "updated_at",                        :null => false
  end

end
