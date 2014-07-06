# encoding: UTF-8
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

ActiveRecord::Schema.define(version: 20140705200016) do

  create_table "who_to_blame_authors", force: true do |t|
    t.string   "full_name",  null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "who_to_blame_authors", ["full_name"], name: "index_who_to_blame_authors_on_full_name", unique: true

  create_table "who_to_blame_file_types", force: true do |t|
    t.string   "name",       null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "who_to_blame_file_types", ["name"], name: "index_who_to_blame_file_types_on_name", unique: true

  create_table "who_to_blame_footprints", force: true do |t|
    t.date     "date",         null: false
    t.integer  "num_lines",    null: false
    t.integer  "author_id",    null: false
    t.integer  "file_type_id", null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
