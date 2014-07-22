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

ActiveRecord::Schema.define(version: 20140722003335) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "checklist_items", force: true do |t|
    t.string   "check_name"
    t.text     "check_description"
    t.integer  "checklist_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "create_user_id"
  end

  create_table "checklists", force: true do |t|
    t.string   "name"
    t.text     "description"
    t.date     "expires_on"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "create_user_id"
    t.string   "recur_on"
    t.integer  "assigned_to_id"
    t.date     "start_on"
    t.integer  "notify_hour"
    t.string   "assigned_to_email"
  end

  create_table "task_items", force: true do |t|
    t.integer  "checklist_item_id"
    t.integer  "checklist_id"
    t.boolean  "completed"
    t.text     "notes"
    t.integer  "completed_by_user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "task_id"
  end

  create_table "tasks", force: true do |t|
    t.integer  "checklist_id"
    t.integer  "assigned_to_id"
    t.date     "task_date"
    t.string   "assigned_to_email"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", force: true do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

end
