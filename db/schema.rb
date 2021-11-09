# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2020_05_27_154833) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "carts", force: :cascade do |t|
    t.bigint "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "checkout_session_id"
    t.index ["user_id"], name: "index_carts_on_user_id"
  end

  create_table "orders", force: :cascade do |t|
    t.bigint "user_id"
    t.bigint "pack_id"
    t.integer "price"
    t.string "tracking"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "category"
    t.integer "quantity"
    t.string "weight"
    t.string "state"
    t.string "pack_sku"
    t.jsonb "payment"
    t.integer "price_cents", default: 0, null: false
    t.string "reduction"
    t.boolean "ar", default: false
    t.boolean "pb", default: false
    t.string "format"
    t.bigint "cart_id"
    t.index ["cart_id"], name: "index_orders_on_cart_id"
    t.index ["pack_id"], name: "index_orders_on_pack_id"
    t.index ["user_id"], name: "index_orders_on_user_id"
  end

  create_table "packs", force: :cascade do |t|
    t.string "title"
    t.string "category"
    t.integer "weight"
    t.integer "quantity"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "infos"
    t.string "photo"
    t.string "description"
    t.string "delivered"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "name"
    t.string "entreprise"
    t.string "siret"
    t.string "address"
    t.boolean "admin", default: false
    t.string "prenom"
    t.integer "codepostal"
    t.string "ville"
    t.boolean "comfirm_data"
    t.string "phone"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "carts", "users"
end
