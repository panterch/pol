# This file is auto-generated from the current state of the database. Instead of editing this file, 
# please use the migrations feature of Active Record to incrementally modify your database, and
# then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your database schema. If you need
# to create the application database on another system, you should be using db:schema:load, not running
# all the migrations from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20100222110507) do

  create_table "comps", :force => true do |t|
    t.integer  "page_id"
    t.string   "type"
    t.integer  "parent_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "media_file_name"
    t.string   "media_content_type"
    t.integer  "media_file_size"
    t.datetime "media_updated_at"
    t.float    "lat"
    t.float    "lng"
    t.integer  "level"
    t.string   "style_class"
    t.integer  "position"
    t.text     "content"
    t.string   "string_1"
    t.string   "string_2"
    t.text     "text_1"
  end

  create_table "contacts", :force => true do |t|
    t.string   "from"
    t.string   "name"
    t.string   "phone"
    t.text     "body"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "pages", :force => true do |t|
    t.integer  "parent_id"
    t.integer  "position"
    t.string   "title"
    t.string   "desc"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "icon_file_name"
    t.string   "icon_content_type"
    t.integer  "icon_file_size"
    t.datetime "icon_updated_at"
    t.string   "permalink"
    t.text     "help"
    t.string   "style_class"
    t.boolean  "hidden"
  end

  add_index "pages", ["permalink"], :name => "index_pages_on_permalink", :unique => true

  create_table "settings", :force => true do |t|
    t.string   "owner_type", :null => false
    t.integer  "owner_id",   :null => false
    t.string   "name",       :null => false
    t.string   "value"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
