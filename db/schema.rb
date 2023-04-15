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

ActiveRecord::Schema[7.0].define(version: 2023_04_15_232050) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "accounts", force: :cascade do |t|
    t.decimal "balance", precision: 8, scale: 2
    t.bigint "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_accounts_on_user_id"
  end

  create_table "transactions", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "member_id"
    t.bigint "pal_id"
    t.decimal "amount", precision: 8, scale: 2, null: false
    t.index ["member_id"], name: "index_transactions_on_member_id"
    t.index ["pal_id"], name: "index_transactions_on_pal_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email"
    t.string "first_name"
    t.string "last_name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
  end

  create_table "visits", force: :cascade do |t|
    t.datetime "date", precision: nil, null: false
    t.integer "minutes", null: false
    t.date "completed_at"
    t.bigint "member_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.decimal "rate", precision: 8, scale: 2, default: "1.0", null: false
    t.index ["completed_at"], name: "index_visits_on_completed_at"
    t.index ["member_id"], name: "index_visits_on_member_id"
  end

  add_foreign_key "accounts", "users"
  add_foreign_key "transactions", "users", column: "member_id"
  add_foreign_key "transactions", "users", column: "pal_id"
  add_foreign_key "visits", "users", column: "member_id"
end
