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
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20131023092642) do

  create_table "adverts", force: true do |t|
    t.string    "title"
    t.string    "mp3_file_name"
    t.string    "mp3_content_type"
    t.integer   "mp3_file_size"
    t.timestamp "mp3_updated_at"
    t.timestamp "created_at"
    t.timestamp "updated_at"
  end

  create_table "podcasts", force: true do |t|
    t.string    "title"
    t.integer   "user_id"
    t.string    "mp3_file_name"
    t.string    "mp3_content_type"
    t.integer   "mp3_file_size"
    t.timestamp "mp3_updated_at"
    t.timestamp "created_at"
    t.timestamp "updated_at"
    t.timestamp "pub_date"
    t.string    "description"
  end

  create_table "posts", force: true do |t|
    t.string    "title"
    t.text      "body"
    t.timestamp "created_at",         null: false
    t.timestamp "updated_at",         null: false
    t.string    "image_file_name"
    t.string    "image_content_type"
    t.integer   "image_file_size"
    t.timestamp "image_updated_at"
  end

  create_table "shows", force: true do |t|
    t.string    "title"
    t.integer   "user_id"
    t.timestamp "time"
    t.timestamp "created_at",         null: false
    t.timestamp "updated_at",         null: false
    t.text      "description"
    t.string    "image_file_name"
    t.string    "image_content_type"
    t.integer   "image_file_size"
    t.timestamp "image_updated_at"
    t.datetime  "end_time"
    t.text      "guests"
  end

  create_table "users", force: true do |t|
    t.string    "username",               default: ""
    t.timestamp "created_at",                          null: false
    t.timestamp "updated_at",                          null: false
    t.string    "email",                  default: "", null: false
    t.string    "encrypted_password",     default: "", null: false
    t.string    "reset_password_token"
    t.timestamp "reset_password_sent_at"
    t.timestamp "remember_created_at"
    t.integer   "sign_in_count",          default: 0
    t.timestamp "current_sign_in_at"
    t.timestamp "last_sign_in_at"
    t.string    "current_sign_in_ip"
    t.string    "last_sign_in_ip"
    t.string    "role"
    t.string    "avatar_file_name"
    t.string    "avatar_content_type"
    t.integer   "avatar_file_size"
    t.timestamp "avatar_updated_at"
    t.string    "time_zone"
    t.text      "likes"
    t.text      "hates"
    t.text      "favorite_food"
    t.text      "style"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true

end
