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

ActiveRecord::Schema[7.0].define(version: 2024_03_01_205906) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "admin_emails", force: :cascade do |t|
    t.string "email"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_admin_emails_on_email"
  end

  create_table "admins", force: :cascade do |t|
    t.string "email", null: false
    t.string "full_name"
    t.string "uid"
    t.string "avatar_url"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "is_officer", default: false
    t.boolean "is_admin", default: false
    t.index ["email"], name: "index_admins_on_email", unique: true
  end

  create_table "checks", force: :cascade do |t|
    t.string "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "organization_name"
    t.string "account_number"
    t.date "date"
    t.string "payable_name"
    t.string "payable_phone_number"
    t.text "payable_address"
    t.string "payment_method"
    t.string "role"
    t.bigint "sub_account_id"
    t.text "approval_status"
    t.text "comments"
    t.decimal "dollar_amount", precision: 10, scale: 2
    t.decimal "travel", precision: 10, scale: 2, default: "0.0"
    t.decimal "food", precision: 10, scale: 2, default: "0.0"
    t.decimal "office_supplies", precision: 10, scale: 2, default: "0.0"
    t.decimal "utilities", precision: 10, scale: 2, default: "0.0"
    t.decimal "membership", precision: 10, scale: 2, default: "0.0"
    t.decimal "clothing", precision: 10, scale: 2, default: "0.0"
    t.decimal "rent", precision: 10, scale: 2, default: "0.0"
    t.decimal "other_expenses", precision: 10, scale: 2, default: "0.0"
    t.decimal "items_for_resale", precision: 10, scale: 2, default: "0.0"
    t.decimal "services_and_other_income", precision: 10, scale: 2, default: "0.0"
    t.bigint "admin_id", null: false
    t.index ["admin_id"], name: "index_checks_on_admin_id"
    t.index ["sub_account_id"], name: "index_checks_on_sub_account_id"
  end

  create_table "officer_emails", force: :cascade do |t|
    t.string "email"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "people", force: :cascade do |t|
    t.string "name"
    t.string "address"
    t.integer "uin"
    t.integer "phone_number"
    t.boolean "tamu_student"
    t.boolean "tamu_employee"
    t.boolean "not_affiliated"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "sub_accounts", force: :cascade do |t|
    t.bigint "sub_account_number"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "owner_name"
  end

  add_foreign_key "checks", "admins"
  add_foreign_key "checks", "sub_accounts"
end
