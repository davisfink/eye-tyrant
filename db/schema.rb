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

ActiveRecord::Schema.define(version: 20180104160129) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "actions", force: :cascade do |t|
    t.string "name"
    t.text "text"
    t.string "attack"
  end

  create_table "characters", force: :cascade do |t|
    t.integer "participant_id"
    t.string "name"
    t.string "race"
    t.integer "party_id"
  end

  create_table "encounters", force: :cascade do |t|
    t.boolean "active"
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

  create_table "legendary", force: :cascade do |t|
    t.string "name"
    t.text "text"
    t.string "attack"
  end

  create_table "monster_types", force: :cascade do |t|
    t.string "name"
    t.string "size"
    t.string "type"
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
    t.string "trait"
    t.string "action"
    t.text "legendary"
    t.string "spells"
    t.string "slots"
    t.string "description"
  end

  create_table "monsters", force: :cascade do |t|
    t.integer "participant_id"
    t.string "name"
    t.integer "monster_type_id"
  end

  create_table "participants", force: :cascade do |t|
    t.integer "damage"
    t.integer "hitpoints"
    t.integer "initiative"
  end

  create_table "parties", force: :cascade do |t|
    t.string "name"
    t.boolean "active"
  end

end
