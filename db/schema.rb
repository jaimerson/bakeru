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

ActiveRecord::Schema.define(version: 20180409090125) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "characters", id: :serial, force: :cascade do |t|
    t.string "color", null: false
    t.string "weapon", default: "unarmed", null: false
    t.integer "vitality", default: 1, null: false
    t.integer "strength", default: 1, null: false
    t.integer "magic", default: 1, null: false
    t.integer "endurance", default: 1, null: false
    t.string "name", null: false
    t.integer "level", default: 1, null: false
  end

end
