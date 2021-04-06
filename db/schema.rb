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

ActiveRecord::Schema.define(version: 2021_04_01_140411) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "ams_subjects", force: :cascade do |t|
    t.string "code"
    t.string "title"
    t.bigint "subject_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["subject_id"], name: "index_ams_subjects_on_subject_id"
  end

  create_table "locations", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "people", force: :cascade do |t|
    t.string "first_name"
    t.string "last_name"
    t.string "email"
    t.string "affiliation"
    t.jsonb "subject"
    t.jsonb "areas_of_expertise"
    t.text "biography"
    t.boolean "deceased"
    t.boolean "retired"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "proposal_fields", force: :cascade do |t|
    t.string "type"
    t.string "statement"
    t.bigint "proposal_form_id", null: false
    t.integer "location_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["proposal_form_id"], name: "index_proposal_fields_on_proposal_form_id"
  end

  create_table "proposal_forms", force: :cascade do |t|
    t.integer "status"
    t.bigint "proposal_type_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["proposal_type_id"], name: "index_proposal_forms_on_proposal_type_id"
  end

  create_table "proposal_type_locations", force: :cascade do |t|
    t.bigint "proposal_type_id", null: false
    t.bigint "location_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["location_id"], name: "index_proposal_type_locations_on_location_id"
    t.index ["proposal_type_id"], name: "index_proposal_type_locations_on_proposal_type_id"
  end

  create_table "proposal_types", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "proposals", force: :cascade do |t|
    t.bigint "location_id", null: false
    t.bigint "proposal_type_id", null: false
    t.jsonb "submission"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["location_id"], name: "index_proposals_on_location_id"
    t.index ["proposal_type_id"], name: "index_proposals_on_proposal_type_id"
  end

  create_table "subject_categories", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "subjects", force: :cascade do |t|
    t.string "code"
    t.string "title"
    t.bigint "subject_category_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["subject_category_id"], name: "index_subjects_on_subject_category_id"
  end

  add_foreign_key "ams_subjects", "subjects"
  add_foreign_key "proposal_fields", "proposal_forms"
  add_foreign_key "proposal_forms", "proposal_types"
  add_foreign_key "proposal_type_locations", "locations"
  add_foreign_key "proposal_type_locations", "proposal_types"
  add_foreign_key "proposals", "locations"
  add_foreign_key "proposals", "proposal_types"
  add_foreign_key "subjects", "subject_categories"
end
