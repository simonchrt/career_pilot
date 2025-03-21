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

ActiveRecord::Schema[7.1].define(version: 2025_03_21_092142) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "application_steps", force: :cascade do |t|
    t.bigint "application_id", null: false
    t.string "step_type"
    t.datetime "date"
    t.text "notes"
    t.boolean "completed"
    t.date "next_action_date"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["application_id"], name: "index_application_steps_on_application_id"
  end

  create_table "applications", force: :cascade do |t|
    t.string "status"
    t.bigint "user_id", null: false
    t.bigint "job_listing_id", null: false
    t.date "applied_date"
    t.date "response_date"
    t.date "interview_date"
    t.text "notes"
    t.integer "priority"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["job_listing_id"], name: "index_applications_on_job_listing_id"
    t.index ["user_id"], name: "index_applications_on_user_id"
  end

  create_table "companies", force: :cascade do |t|
    t.string "name"
    t.string "website"
    t.string "logo"
    t.string "industry"
    t.string "location"
    t.string "size"
    t.text "notes"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "job_listings", force: :cascade do |t|
    t.string "title"
    t.text "description"
    t.string "url"
    t.bigint "company_id", null: false
    t.boolean "remote"
    t.integer "salary_min"
    t.integer "salary_max"
    t.string "currency"
    t.string "contract_type"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["company_id"], name: "index_job_listings_on_company_id"
  end

  create_table "job_technologies", force: :cascade do |t|
    t.bigint "job_listing_id", null: false
    t.bigint "technology_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["job_listing_id"], name: "index_job_technologies_on_job_listing_id"
    t.index ["technology_id"], name: "index_job_technologies_on_technology_id"
  end

  create_table "oauth_providers", force: :cascade do |t|
    t.string "provider"
    t.string "uid"
    t.bigint "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_oauth_providers_on_user_id"
  end

  create_table "technologies", force: :cascade do |t|
    t.string "name"
    t.string "category"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.string "first_name"
    t.string "last_name"
    t.string "username"
    t.boolean "profile_completed", default: false
    t.boolean "admin", default: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "application_steps", "applications"
  add_foreign_key "applications", "job_listings"
  add_foreign_key "applications", "users"
  add_foreign_key "job_listings", "companies"
  add_foreign_key "job_technologies", "job_listings"
  add_foreign_key "job_technologies", "technologies"
  add_foreign_key "oauth_providers", "users"
end
