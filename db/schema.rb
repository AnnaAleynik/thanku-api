# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `rails
# db:schema:load`. When creating a new database, `rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2022_05_23_102855) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "citext"
  enable_extension "plpgsql"

  create_table "activities", force: :cascade do |t|
    t.string "title", null: false
    t.text "body", null: false
    t.string "event", null: false
    t.bigint "user_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["user_id"], name: "index_activities_on_user_id"
  end

  create_table "bonus_transfers", force: :cascade do |t|
    t.integer "amount", null: false
    t.string "comment", null: false
    t.bigint "sender_id", null: false
    t.bigint "receiver_id", null: false
    t.bigint "parent_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["parent_id"], name: "index_bonus_transfers_on_parent_id"
    t.index ["receiver_id"], name: "index_bonus_transfers_on_receiver_id"
    t.index ["sender_id"], name: "index_bonus_transfers_on_sender_id"
  end

  create_table "companies", force: :cascade do |t|
    t.string "name", null: false
    t.string "description"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "bonus_amount", default: 100, null: false
  end

  create_table "possession_tokens", force: :cascade do |t|
    t.string "value", null: false
    t.bigint "user_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["user_id"], name: "index_possession_tokens_on_user_id"
  end

  create_table "products", force: :cascade do |t|
    t.string "name", null: false
    t.string "description"
    t.integer "count", default: 0, null: false
    t.integer "price", default: 0, null: false
    t.text "picture_data"
    t.bigint "company_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["company_id"], name: "index_products_on_company_id"
  end

  create_table "refresh_tokens", force: :cascade do |t|
    t.string "token", null: false
    t.bigint "user_id", null: false
    t.datetime "expires_at", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "jti"
    t.index ["jti"], name: "index_refresh_tokens_on_jti"
    t.index ["token"], name: "index_refresh_tokens_on_token"
    t.index ["user_id"], name: "index_refresh_tokens_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.citext "email", null: false
    t.string "first_name"
    t.string "last_name"
    t.string "password_digest", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.text "avatar_data"
    t.string "password_reset_token"
    t.datetime "password_reset_sent_at"
    t.datetime "confirmed_at"
    t.string "login"
    t.integer "bonus_balance", default: 0, null: false
    t.integer "bonus_allowance", default: 500, null: false
    t.string "role", default: "account", null: false
    t.date "birthdate"
    t.bigint "company_id"
    t.string "invitation_token"
    t.datetime "invitation_sent_at"
    t.datetime "invitation_accepted_at"
    t.bigint "invited_by_id"
    t.index ["company_id"], name: "index_users_on_company_id"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["invited_by_id"], name: "index_users_on_invited_by_id"
    t.index ["password_reset_token"], name: "index_users_on_password_reset_token"
  end

  add_foreign_key "activities", "users"
  add_foreign_key "bonus_transfers", "bonus_transfers", column: "parent_id"
  add_foreign_key "bonus_transfers", "users", column: "receiver_id"
  add_foreign_key "bonus_transfers", "users", column: "sender_id"
  add_foreign_key "possession_tokens", "users"
  add_foreign_key "refresh_tokens", "users"
  add_foreign_key "users", "companies"
end
