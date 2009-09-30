class PolTables < ActiveRecord::Migration

  def self.up
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
      t.string   "title" unless pol_cfg.multilang?
      t.text     "desc" unless pol_cfg.multilang?
    end
    add_index "pages", ["permalink"], :name => "index_pages_on_permalink", :unique => true

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
      t.text     "content" unless pol_cfg.multilang?
    end

    create_table "contacts", :force => true do |t|
      t.string   "from"
      t.string   "name"
      t.string   "phone"
      t.text     "body"
      t.datetime "created_at"
      t.datetime "updated_at"
    end

    if pol_cfg.multilang?
      Comp.create_translation_table! :content => :text
      Page.create_translation_table! :title => :string, :desc => :string
    end
  end

  def self.down
    drop_table :comps
    Comp.drop_translation_table! if pol_cfg.multilang?
    drop_table :contacts
    drop_table :pages
  end

end
