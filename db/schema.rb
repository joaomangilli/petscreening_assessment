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

ActiveRecord::Schema[7.1].define(version: 2024_06_07_185550) do
  create_table "breeds", force: :cascade do |t|
    t.string "name", null: false
    t.text "description", null: false
    t.integer "life_min", null: false
    t.integer "life_max", null: false
    t.integer "male_weight_min", null: false
    t.integer "male_weight_max", null: false
    t.integer "female_weight_min", null: false
    t.integer "female_weight_max", null: false
    t.boolean "hypoallergenic", default: false, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["name"], name: "index_breeds_on_name", unique: true
  end

  create_table "owners", force: :cascade do |t|
    t.string "name", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "pets", force: :cascade do |t|
    t.string "name"
    t.string "kind"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "breed_id"
    t.integer "weight"
    t.integer "owner_id"
    t.index ["breed_id"], name: "index_pets_on_breed_id"
    t.index ["owner_id"], name: "index_pets_on_owner_id"
  end

  add_foreign_key "pets", "breeds"
  add_foreign_key "pets", "owners"
end
