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

ActiveRecord::Schema.define(version: 20170926115553) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "groups", force: :cascade do |t|
    t.string "name", null: false
    t.string "tenant", null: false
    t.string "adress"
    t.string "email"
    t.jsonb "contact"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["name"], name: "index_groups_on_name", unique: true
    t.index ["tenant"], name: "index_groups_on_tenant", unique: true
  end

  create_table "receipts", force: :cascade do |t|
    t.string "type"
    t.integer "serie"
    t.integer "number"
    t.string "name"
    t.string "adress"
    t.decimal "total"
    t.jsonb "image_data"
    t.bigint "representative_id"
    t.bigint "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["name"], name: "index_receipts_on_name"
    t.index ["number"], name: "index_receipts_on_number"
    t.index ["representative_id"], name: "index_receipts_on_representative_id"
    t.index ["serie"], name: "index_receipts_on_serie"
    t.index ["type"], name: "index_receipts_on_type"
    t.index ["user_id"], name: "index_receipts_on_user_id"
  end

  create_table "representatives", force: :cascade do |t|
    t.string "fullname"
    t.string "adress"
    t.string "wilaya"
    t.jsonb "contact"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "email"
    t.index ["contact"], name: "index_representatives_on_contact", using: :gin
    t.index ["fullname"], name: "index_representatives_on_fullname", unique: true
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "username", default: "", null: false
    t.string "type", default: "Public", null: false
    t.bigint "group_id"
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet "current_sign_in_ip"
    t.inet "last_sign_in_ip"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["group_id"], name: "index_users_on_group_id"
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
    t.index ["type"], name: "index_users_on_type"
    t.index ["username"], name: "index_users_on_username", unique: true
  end

  add_foreign_key "receipts", "representatives"
  add_foreign_key "receipts", "users"
end
