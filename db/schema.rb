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

ActiveRecord::Schema.define(version: 20180404131202) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "actions", force: :cascade do |t|
    t.string "name"
    t.string "attack"
    t.text "text", array: true
    t.bigint "monster_type_id"
    t.index ["monster_type_id"], name: "index_actions_on_monster_type_id"
  end

  create_table "actions_monster_types", id: false, force: :cascade do |t|
    t.bigint "monster_type_id", null: false
    t.bigint "action_id", null: false
  end

  create_table "challenge_multipliers", force: :cascade do |t|
    t.integer "value"
    t.float "multiplier"
  end

  create_table "challenge_ratings", force: :cascade do |t|
    t.integer "level"
    t.integer "easy"
    t.integer "medium"
    t.integer "hard"
    t.integer "deadly"
  end

  create_table "characters", force: :cascade do |t|
    t.integer "participant_id"
    t.string "name"
    t.integer "party_id"
    t.bigint "races_id"
    t.index ["races_id"], name: "index_characters_on_races_id"
  end

  create_table "conditions", force: :cascade do |t|
    t.string "name"
    t.text "description", array: true
  end

  create_table "conditions_participants", id: false, force: :cascade do |t|
    t.bigint "participant_id", null: false
    t.bigint "condition_id", null: false
  end

  create_table "encounters", force: :cascade do |t|
    t.boolean "active", default: true
    t.integer "party_id"
    t.integer "active_participant_id"
  end

  create_table "encounters_participants", force: :cascade do |t|
    t.integer "encounter_id"
    t.integer "participant_id"
  end

  create_table "experience", force: :cascade do |t|
    t.string "cr"
    t.integer "xp"
  end

  create_table "legendaries", force: :cascade do |t|
    t.string "name"
    t.string "attack"
    t.text "text", array: true
  end

  create_table "legendaries_monster_types", id: false, force: :cascade do |t|
    t.bigint "legendary_id", null: false
    t.bigint "monster_type_id", null: false
  end

  create_table "monster_types", force: :cascade do |t|
    t.string "name"
    t.string "size"
    t.string "alignment"
    t.string "ac"
    t.string "hp"
    t.string "speed"
    t.integer "str"
    t.integer "dex"
    t.integer "con"
    t.integer "int"
    t.integer "wis"
    t.integer "cha"
    t.string "save"
    t.string "skill"
    t.string "vulnerable"
    t.string "resist"
    t.string "immune"
    t.string "conditionimmune"
    t.string "senses"
    t.string "passive"
    t.string "languages"
    t.string "cr"
    t.string "slots"
    t.string "description"
    t.bigint "type_id"
    t.index ["type_id"], name: "index_monster_types_on_type_id"
  end

  create_table "monster_types_spells", id: false, force: :cascade do |t|
    t.bigint "monster_type_id", null: false
    t.bigint "spell_id", null: false
  end

  create_table "monster_types_traits", id: false, force: :cascade do |t|
    t.bigint "monster_type_id", null: false
    t.bigint "trait_id", null: false
  end

  create_table "monster_types_types", id: false, force: :cascade do |t|
    t.bigint "type_id", null: false
    t.bigint "monster_type_id", null: false
  end

  create_table "monsters", force: :cascade do |t|
    t.integer "participant_id"
    t.string "name"
    t.integer "monster_type_id"
  end

  create_table "participants", force: :cascade do |t|
    t.integer "damage", default: 0
    t.integer "hitpoints", default: 0
    t.integer "initiative", default: 0
    t.boolean "active", default: true
  end

  create_table "parties", force: :cascade do |t|
    t.string "name"
    t.boolean "active", default: true
    t.integer "level", default: 1
  end

  create_table "races", force: :cascade do |t|
    t.string "name"
    t.string "size"
    t.string "speed"
    t.string "ability"
    t.string "proficiency"
  end

  create_table "races_traits", id: false, force: :cascade do |t|
    t.bigint "race_id", null: false
    t.bigint "trait_id", null: false
  end

  create_table "spells", force: :cascade do |t|
    t.string "name"
    t.string "school"
    t.string "time"
    t.string "range"
    t.string "components"
    t.string "duration"
    t.text "classes"
    t.text "text", array: true
    t.text "roll", array: true
    t.string "level"
  end

  create_table "testerson", force: :cascade do |t|
    t.string "tacos"
  end

  create_table "traits", force: :cascade do |t|
    t.string "name"
    t.text "text", array: true
    t.bigint "monster_type_id"
    t.text "attack"
    t.index ["monster_type_id"], name: "index_traits_on_monster_type_id"
  end

  create_table "types", force: :cascade do |t|
    t.string "name"
    t.string "race"
    t.string "source"
  end

  add_foreign_key "characters", "races", column: "races_id"
  add_foreign_key "monster_types", "types"
end
