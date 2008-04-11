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

ActiveRecord::Schema.define(:version => 3) do

  create_table "articles", :force => true do |t|
    t.string   "title"
    t.string   "permalink"
    t.integer  "comments_count", :default => 0
    t.integer  "commenting",     :default => 0
    t.text     "excerpt"
    t.text     "body"
    t.text     "excerpt_html"
    t.text     "body_html"
    t.string   "filter"
    t.datetime "published_at"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "articles", ["published_at"], :name => "index_articles_on_published_at"
  add_index "articles", ["permalink"], :name => "index_articles_on_permalink"

  create_table "assets", :force => true do |t|
    t.string   "filename"
    t.integer  "width"
    t.integer  "height"
    t.string   "content_type"
    t.integer  "size"
    t.string   "attachable_type"
    t.integer  "attachable_id"
    t.string   "thumbnail"
    t.integer  "parent_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "assets", ["parent_id"], :name => "index_assets_on_parent_id"
  add_index "assets", ["attachable_id"], :name => "index_assets_on_attachable_id"
  add_index "assets", ["attachable_type"], :name => "index_assets_on_attachable_type"

  create_table "comments", :force => true do |t|
    t.integer  "article_id"
    t.boolean  "admin",      :default => false
    t.string   "user_ip"
    t.string   "user_agent"
    t.string   "referrer"
    t.boolean  "approved",   :default => false
    t.string   "name"
    t.string   "email"
    t.string   "website"
    t.text     "yay",        :default => ""
    t.text     "nay",        :default => ""
    t.integer  "vote_count", :default => 1
    t.text     "body"
    t.text     "body_html"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "comments", ["approved"], :name => "index_comments_on_approved"
  add_index "comments", ["article_id"], :name => "index_comments_on_article_id"

end
