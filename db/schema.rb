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

ActiveRecord::Schema.define(:version => 20120630095709) do

  create_table "active_admin_comments", :force => true do |t|
    t.string   "resource_id",   :null => false
    t.string   "resource_type", :null => false
    t.integer  "author_id"
    t.string   "author_type"
    t.text     "body"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
    t.string   "namespace"
  end

  add_index "active_admin_comments", ["author_type", "author_id"], :name => "index_active_admin_comments_on_author_type_and_author_id"
  add_index "active_admin_comments", ["namespace"], :name => "index_active_admin_comments_on_namespace"
  add_index "active_admin_comments", ["resource_type", "resource_id"], :name => "index_admin_notes_on_resource_type_and_resource_id"

  create_table "authors", :force => true do |t|
    t.string   "first_name",                                                 :null => false
    t.string   "last_name",                                                  :null => false
    t.string   "email",                                                      :null => false
    t.string   "website"
    t.text     "about"
    t.text     "meta",                   :limit => 16777215
    t.string   "encrypted_password",                         :default => "", :null => false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",                              :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at",                                                 :null => false
    t.datetime "updated_at",                                                 :null => false
  end

  add_index "authors", ["email"], :name => "index_authors_on_email", :unique => true
  add_index "authors", ["reset_password_token"], :name => "index_authors_on_reset_password_token", :unique => true

  create_table "categories", :force => true do |t|
    t.string "name", :limit => 200, :null => false
    t.string "slug", :limit => 200, :null => false
  end

  create_table "categories_posts", :id => false, :force => true do |t|
    t.integer "category_id", :null => false
    t.integer "post_id",     :null => false
  end

  add_index "categories_posts", ["category_id", "post_id"], :name => "index_categories_posts_on_category_id_and_post_id"
  add_index "categories_posts", ["post_id", "category_id"], :name => "index_categories_posts_on_post_id_and_category_id"

  create_table "comments", :force => true do |t|
    t.integer  "post_id",                                         :null => false
    t.integer  "author_id"
    t.string   "author_name",    :limit => 100,                   :null => false
    t.string   "author_email",   :limit => 60
    t.string   "author_website", :limit => 100
    t.string   "author_ip",      :limit => 100,                   :null => false
    t.text     "comment",                                         :null => false
    t.string   "hierarchy",      :limit => 2048, :default => "0", :null => false
    t.datetime "created_at",                                      :null => false
    t.datetime "updated_at",                                      :null => false
  end

  add_index "comments", ["author_id"], :name => "index_comments_on_author_id"
  add_index "comments", ["post_id"], :name => "index_comments_on_post_id"

  create_table "posts", :force => true do |t|
    t.string   "post_title",    :limit => 512,                       :null => false
    t.string   "slug",          :limit => 200,                       :null => false
    t.text     "post_excerpt",                                       :null => false
    t.text     "post_content",  :limit => 2147483647,                :null => false
    t.integer  "comment_count",                                      :null => false
    t.integer  "author_id",                                          :null => false
    t.integer  "published",     :limit => 1,          :default => 0, :null => false
    t.datetime "created_at",                                         :null => false
    t.datetime "updated_at",                                         :null => false
  end

  add_index "posts", ["author_id"], :name => "index_posts_on_author_id"

end
