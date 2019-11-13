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

ActiveRecord::Schema.define(version: 2019_11_13_063024) do

  create_table "customers", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "last_name", null: false
    t.string "first_name", null: false
    t.string "last_name_kana", null: false
    t.string "first_name_kana", null: false
    t.string "postal_code1", null: false
    t.string "postal_code2", null: false
    t.integer "prefecture_code", null: false
    t.string "city", null: false
    t.string "building", null: false
    t.string "phone_number1", null: false
    t.string "phone_number2", null: false
    t.string "phone_number3", null: false
    t.datetime "deleted_at"
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_customers_on_email", unique: true
    t.index ["reset_password_token"], name: "index_customers_on_reset_password_token", unique: true
  end

  create_table "orders", force: :cascade do |t|
    t.string "postal_code1", null: false
    t.string "postal_code2", null: false
    t.integer "prefecture_code", null: false
    t.string "city", null: false
    t.string "building", null: false
    t.integer "total", null: false
    t.integer "status", null: false
    t.integer "tax_id", null: false
    t.integer "product_id", null: false
    t.integer "customer_id", null: false
    t.integer "payment", null: false
    t.integer "postage_id", null: false
    t.integer "quantity", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "products", force: :cascade do |t|
    t.string "name", null: false
    t.integer "price", null: false
    t.text "image_id", null: false
    t.date "release_date", null: false
    t.integer "status", default: 0, null: false
    t.text "description", null: false
    t.integer "artist_id", null: false
    t.integer "category_id", null: false
    t.integer "company_id", null: false
    t.datetime "deleted_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

end
