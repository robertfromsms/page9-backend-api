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

ActiveRecord::Schema.define(version: 2019_08_24_190737) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "exchange_items", force: :cascade do |t|
    t.bigint "exchange_id", null: false
    t.bigint "item_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["exchange_id"], name: "index_exchange_items_on_exchange_id"
    t.index ["item_id"], name: "index_exchange_items_on_item_id"
  end

  create_table "exchanges", force: :cascade do |t|
    t.integer "seller_ident", null: false
    t.integer "buyer_ident", null: false
    t.string "exchange_status", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "items", force: :cascade do |t|
    t.bigint "product_id", null: false
    t.string "want_have_removed", null: false
    t.float "listing_price"
    t.string "additional_info"
    t.bigint "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["product_id"], name: "index_items_on_product_id"
    t.index ["user_id"], name: "index_items_on_user_id"
  end

  create_table "products", force: :cascade do |t|
    t.string "name", null: false
    t.string "outside_ident", null: false
    t.string "img_path", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string "user_name", null: false
    t.string "full_name", null: false
    t.string "address", null: false
    t.string "password_digest", null: false
    t.string "account_status"
    t.string "email"
    t.integer "seller_score"
    t.integer "buyer_score"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_foreign_key "exchange_items", "exchanges"
  add_foreign_key "exchange_items", "items"
  add_foreign_key "items", "products"
  add_foreign_key "items", "users"
end
