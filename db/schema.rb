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

ActiveRecord::Schema.define(version: 2019_07_03_124801) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "address_records", force: :cascade do |t|
    t.string "ip_address", null: false
    t.datetime "last_visited", default: "2019-07-03 14:04:32", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "clusters", force: :cascade do |t|
    t.string "stamp"
    t.integer "number_of_fragments"
    t.integer "total_character_count"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "fragments", force: :cascade do |t|
    t.bigint "cluster_id"
    t.integer "cluster_order"
    t.text "content"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["cluster_id"], name: "index_fragments_on_cluster_id"
  end

  create_table "house_images", force: :cascade do |t|
    t.string "image"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

end
