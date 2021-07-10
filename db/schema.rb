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

ActiveRecord::Schema.define(version: 2021_05_07_151507) do

  create_table "distance_factors", force: :cascade do |t|
    t.integer "initial"
    t.integer "final"
    t.integer "factor"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "job_candidates", force: :cascade do |t|
    t.integer "job_id"
    t.integer "person_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "score"
    t.index ["job_id"], name: "index_job_candidates_on_job_id"
    t.index ["person_id"], name: "index_job_candidates_on_person_id"
  end

  create_table "jobs", force: :cascade do |t|
    t.string "company"
    t.string "title"
    t.text "description"
    t.string "localization"
    t.integer "level"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "links", force: :cascade do |t|
    t.string "source"
    t.string "target"
    t.integer "distance"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "people", force: :cascade do |t|
    t.string "name"
    t.string "career"
    t.string "localization"
    t.integer "level"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "professional_background"
  end

  add_foreign_key "job_candidates", "jobs"
  add_foreign_key "job_candidates", "people"
end
