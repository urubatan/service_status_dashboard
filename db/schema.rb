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

ActiveRecord::Schema.define(version: 20180725122238) do

  create_table "service_histories", force: :cascade do |t|
    t.boolean "status"
    t.text "status_text"
    t.boolean "notification_sent"
    t.integer "service_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["service_id"], name: "index_service_histories_on_service_id"
  end

  create_table "services", force: :cascade do |t|
    t.string "name"
    t.string "address"
    t.integer "check_type"
    t.text "check_script"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "current_status"
    t.text "current_text"
  end

end
