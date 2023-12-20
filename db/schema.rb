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

ActiveRecord::Schema[7.0].define(version: 2023_12_18_190731) do
  create_table "integrations", force: :cascade do |t|
    t.text "description"
    t.integer "status", default: 0
    t.string "integrable_type"
    t.integer "integrable_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "user_id"
    t.index ["integrable_type", "integrable_id"], name: "index_integrations_on_integrable"
    t.index ["user_id"], name: "index_integrations_on_user_id"
  end

  create_table "notion_integrations", force: :cascade do |t|
    t.text "page_id"
    t.text "secret_key"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "question_groups", force: :cascade do |t|
    t.integer "source", default: 0
    t.string "source_id"
    t.string "name"
    t.integer "status", default: 0
    t.text "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "user_id"
    t.integer "integration_id"
    t.index ["integration_id"], name: "index_question_groups_on_integration_id"
    t.index ["source_id"], name: "index_question_groups_on_source_id", unique: true
    t.index ["user_id"], name: "index_question_groups_on_user_id"
  end

  create_table "questions", force: :cascade do |t|
    t.integer "source", default: 0
    t.string "source_id"
    t.string "query"
    t.text "answer"
    t.integer "status", default: 0
    t.integer "difficulty_level"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "question_group_id"
    t.integer "user_id"
    t.integer "integration_id"
    t.index ["integration_id"], name: "index_questions_on_integration_id"
    t.index ["question_group_id"], name: "index_questions_on_question_group_id"
    t.index ["source_id"], name: "index_questions_on_source_id", unique: true
    t.index ["user_id", "difficulty_level"], name: "index_questions_on_user_id_and_difficulty_level"
    t.index ["user_id", "source"], name: "index_questions_on_user_id_and_source"
    t.index ["user_id", "status"], name: "index_questions_on_user_id_and_status"
    t.index ["user_id"], name: "index_questions_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "integrations", "users"
  add_foreign_key "question_groups", "integrations"
  add_foreign_key "question_groups", "users"
  add_foreign_key "questions", "integrations"
  add_foreign_key "questions", "question_groups"
  add_foreign_key "questions", "users"
end
