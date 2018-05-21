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

ActiveRecord::Schema.define(version: 2018_05_20_123041) do

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

  create_table "orderables", force: :cascade do |t|
    t.string "type"
    t.bigint "order_id"
    t.bigint "receipt_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.decimal "used", precision: 10, scale: 2, default: "0.0"
    t.index ["order_id"], name: "index_orderables_on_order_id"
    t.index ["receipt_id"], name: "index_orderables_on_receipt_id"
    t.index ["type"], name: "index_orderables_on_type"
  end

  create_table "orders", force: :cascade do |t|
    t.string "type"
    t.integer "number"
    t.decimal "remain", precision: 10, scale: 2, default: "0.0", null: false
    t.jsonb "image_data"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "group_id"
    t.bigint "user_id"
    t.index ["created_at"], name: "index_orders_on_created_at"
    t.index ["group_id"], name: "index_orders_on_group_id"
    t.index ["number"], name: "index_orders_on_number"
    t.index ["remain"], name: "index_orders_on_remain"
    t.index ["type"], name: "index_orders_on_type"
    t.index ["user_id"], name: "index_orders_on_user_id"
  end

  create_table "payements", force: :cascade do |t|
    t.string "type"
    t.decimal "value", precision: 10, scale: 2, default: "0.0", null: false
    t.string "name"
    t.date "date"
    t.jsonb "data"
    t.jsonb "image_data"
    t.bigint "order_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["created_at"], name: "index_payements_on_created_at"
    t.index ["data"], name: "index_payements_on_data", using: :gin
    t.index ["date"], name: "index_payements_on_date"
    t.index ["name"], name: "index_payements_on_name"
    t.index ["order_id"], name: "index_payements_on_order_id"
    t.index ["type"], name: "index_payements_on_type"
  end

  create_table "receipts", force: :cascade do |t|
    t.string "type"
    t.integer "serie"
    t.integer "number"
    t.string "owner_name"
    t.jsonb "owner_adress"
    t.decimal "total", precision: 10, scale: 2, default: "0.0", null: false
    t.jsonb "data"
    t.jsonb "image_data"
    t.bigint "representative_id"
    t.bigint "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "group_id"
    t.integer "status", default: 0
    t.index ["created_at"], name: "index_receipts_on_created_at"
    t.index ["data"], name: "index_receipts_on_data", using: :gin
    t.index ["group_id"], name: "index_receipts_on_group_id"
    t.index ["number"], name: "index_receipts_on_number"
    t.index ["owner_adress"], name: "index_receipts_on_owner_adress", using: :gin
    t.index ["owner_name"], name: "index_receipts_on_owner_name"
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
    t.index ["contact"], name: "index_representatives_on_contact", using: :gin
    t.index ["fullname"], name: "index_representatives_on_fullname", unique: true
  end

  create_table "taxes", force: :cascade do |t|
    t.string "code"
    t.string "description"
    t.string "category"
    t.decimal "current_tax", precision: 10, scale: 2, default: "0.0", null: false
    t.decimal "next_tax", precision: 10, scale: 2, default: "0.0", null: false
    t.date "date_app"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "username", default: "", null: false
    t.string "fullname", default: "", null: false
    t.string "type", default: "Public", null: false
    t.bigint "group_id"
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
    t.index ["type"], name: "index_users_on_type"
    t.index ["username"], name: "index_users_on_username", unique: true
  end

  create_table "whitelists", force: :cascade do |t|
    t.inet "ip_adress"
    t.string "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["ip_adress"], name: "index_whitelists_on_ip_adress"
  end

  add_foreign_key "orderables", "orders"
  add_foreign_key "orderables", "receipts"
  add_foreign_key "orders", "groups"
  add_foreign_key "orders", "users"
  add_foreign_key "payements", "orders"
  add_foreign_key "receipts", "groups"
  add_foreign_key "receipts", "representatives"
  add_foreign_key "receipts", "users"
  add_foreign_key "users", "groups"
end
