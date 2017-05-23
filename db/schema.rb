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

ActiveRecord::Schema.define(version: 20170522094047) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "leaves", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "manager_id"
    t.integer  "leave_type"
    t.string   "leave_reason"
    t.integer  "status"
    t.string   "rejection_reason"
    t.date     "start_date"
    t.date     "end_date"
    t.integer  "total_days"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
    t.string   "image"
    t.index ["manager_id"], name: "index_leaves_on_manager_id", using: :btree
    t.index ["user_id"], name: "index_leaves_on_user_id", using: :btree
  end

  create_table "remaining_leaves", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "annual"
    t.integer  "maternity"
    t.integer  "non_paid"
    t.integer  "study"
    t.integer  "sick"
    t.integer  "emergency"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_remaining_leaves_on_user_id", using: :btree
  end

  create_table "total_leaves", force: :cascade do |t|
    t.integer "user_id"
    t.integer "annual"
    t.integer "maternity"
    t.integer "non_paid"
    t.integer "study"
    t.integer "sick"
    t.integer "emergency"
    t.index ["user_id"], name: "index_total_leaves_on_user_id", using: :btree
  end

  create_table "users", force: :cascade do |t|
    t.datetime "created_at",                      null: false
    t.datetime "updated_at",                      null: false
    t.string   "name"
    t.integer  "position"
    t.string   "email",                           null: false
    t.integer  "department"
    t.integer  "manager_id"
    t.string   "phone_no"
    t.string   "address"
    t.string   "avatar"
    t.string   "private_token"
    t.string   "encrypted_password",  limit: 128, null: false
    t.string   "confirmation_token",  limit: 128
    t.string   "remember_token",      limit: 128, null: false
    t.integer  "total_leafe_id"
    t.integer  "total_annual_leaves"
    t.integer  "remaining_leafe_id"
    t.index ["email"], name: "index_users_on_email", using: :btree
    t.index ["manager_id"], name: "index_users_on_manager_id", using: :btree
    t.index ["name"], name: "index_users_on_name", using: :btree
    t.index ["remaining_leafe_id"], name: "index_users_on_remaining_leafe_id", using: :btree
    t.index ["remember_token"], name: "index_users_on_remember_token", using: :btree
    t.index ["total_leafe_id"], name: "index_users_on_total_leafe_id", using: :btree
  end

end
