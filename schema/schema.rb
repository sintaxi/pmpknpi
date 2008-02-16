# This file is auto-generated from the current state of the database. Instead of editing this file, 
# please use the migrations feature of ActiveRecord to incrementally modify your database, and
# then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your database schema. If you need
# to create the application database on another system, you should be using db:schema:load, not running
# all the migrations from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 2) do

  create_table "articles", :force => true do |t|
    t.string   "title"
    t.string   "permalink"
    t.integer  "comments_count", :default => 0
    t.boolean  "commenting"
    t.boolean  "publish"
    t.text     "excerpt"
    t.text     "body"
    t.text     "excerpt_html"
    t.text     "body_html"
    t.string   "filter"
    t.date     "published_on"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "articles", ["publish"], :name => "index_articles_on_publish"
  add_index "articles", ["permalink"], :name => "index_articles_on_permalink"

  create_table "comments", :force => true do |t|
    t.integer  "article_id"
    t.string   "author"
    t.string   "name"
    t.string   "email"
    t.string   "website"
    t.text     "mods_up",    :default => ""
    t.text     "mods_down",  :default => ""
    t.integer  "mods_count", :default => 1
    t.text     "body"
    t.text     "body_html"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
