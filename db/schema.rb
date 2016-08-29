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

ActiveRecord::Schema.define(version: 20160829205510) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "accounts", force: :cascade do |t|
    t.string   "gender"
    t.string   "first_name"
    t.string   "last_name"
    t.string   "birthdate"
    t.string   "address1"
    t.string   "address2"
    t.integer  "zip_code"
    t.string   "city"
    t.string   "email"
    t.string   "mobile_phone"
    t.string   "perso_phone"
    t.string   "pro_phone"
    t.integer  "coins"
    t.string   "identifiant"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
    t.integer  "user_id"
    t.string   "password"
    t.index ["user_id"], name: "index_accounts_on_user_id", using: :btree
  end

  create_table "bookings", force: :cascade do |t|
    t.integer  "court_id"
    t.string   "date"
    t.string   "hour"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer  "user_id"
    t.integer  "account_id"
    t.integer  "venue_id"
    t.index ["account_id"], name: "index_bookings_on_account_id", using: :btree
    t.index ["court_id"], name: "index_bookings_on_court_id", using: :btree
    t.index ["user_id"], name: "index_bookings_on_user_id", using: :btree
    t.index ["venue_id"], name: "index_bookings_on_venue_id", using: :btree
  end

  create_table "courts", force: :cascade do |t|
    t.integer  "court_number"
    t.string   "surface"
    t.boolean  "roof"
    t.boolean  "lights"
    t.string   "pt_court_id"
    t.string   "pt_venue_id"
    t.string   "pt_court_and_venue_id"
    t.integer  "venue_id"
    t.datetime "created_at",            null: false
    t.datetime "updated_at",            null: false
    t.index ["venue_id"], name: "index_courts_on_venue_id", using: :btree
  end

  create_table "metros", force: :cascade do |t|
    t.string   "station"
    t.integer  "venue_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["venue_id"], name: "index_metros_on_venue_id", using: :btree
  end

  create_table "pictures", force: :cascade do |t|
    t.string   "picture_path"
    t.integer  "venue_id"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
    t.index ["venue_id"], name: "index_pictures_on_venue_id", using: :btree
  end

  create_table "results", force: :cascade do |t|
    t.string   "pt_court_id"
    t.string   "date"
    t.string   "hour"
    t.string   "pt_id"
    t.string   "cle"
    t.string   "libelleReservation"
    t.integer  "user_id"
    t.datetime "created_at",         null: false
    t.datetime "updated_at",         null: false
    t.integer  "venue_id"
    t.integer  "court_id"
    t.index ["court_id"], name: "index_results_on_court_id", using: :btree
    t.index ["user_id"], name: "index_results_on_user_id", using: :btree
    t.index ["venue_id"], name: "index_results_on_venue_id", using: :btree
  end

  create_table "users", force: :cascade do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet     "current_sign_in_ip"
    t.inet     "last_sign_in_ip"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
    t.index ["email"], name: "index_users_on_email", unique: true, using: :btree
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree
  end

  create_table "velibs", force: :cascade do |t|
    t.string   "station"
    t.string   "address"
    t.integer  "venue_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["venue_id"], name: "index_velibs_on_venue_id", using: :btree
  end

  create_table "venues", force: :cascade do |t|
    t.string   "name"
    t.integer  "district"
    t.string   "address"
    t.string   "street"
    t.integer  "zip_code"
    t.string   "city"
    t.string   "phone"
    t.text     "description"
    t.string   "surfaces"
    t.boolean  "handi"
    t.string   "pt_id"
    t.string   "pt_name"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.boolean  "available"
  end

  create_table "votes", force: :cascade do |t|
    t.string   "votable_type"
    t.integer  "votable_id"
    t.string   "voter_type"
    t.integer  "voter_id"
    t.boolean  "vote_flag"
    t.string   "vote_scope"
    t.integer  "vote_weight"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["votable_id", "votable_type", "vote_scope"], name: "index_votes_on_votable_id_and_votable_type_and_vote_scope", using: :btree
    t.index ["voter_id", "voter_type", "vote_scope"], name: "index_votes_on_voter_id_and_voter_type_and_vote_scope", using: :btree
  end

  add_foreign_key "bookings", "courts"
  add_foreign_key "courts", "venues"
  add_foreign_key "metros", "venues"
  add_foreign_key "pictures", "venues"
  add_foreign_key "results", "users"
  add_foreign_key "velibs", "venues"
end
