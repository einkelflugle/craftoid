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

ActiveRecord::Schema.define(version: 20140925012305) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "categories", force: true do |t|
    t.string "name"
    t.text   "description"
    t.string "slug"
  end

  add_index "categories", ["slug"], name: "index_categories_on_slug", using: :btree

  create_table "categories_competitions", id: false, force: true do |t|
    t.integer "category_id"
    t.integer "competition_id"
  end

  create_table "categories_robots", id: false, force: true do |t|
    t.integer "category_id"
    t.integer "robot_id"
  end

  create_table "comments", force: true do |t|
    t.integer  "user_id"
    t.integer  "robot_id"
    t.text     "body"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "comments", ["robot_id"], name: "index_comments_on_robot_id", using: :btree
  add_index "comments", ["user_id"], name: "index_comments_on_user_id", using: :btree

  create_table "competitions", force: true do |t|
    t.string   "name"
    t.text     "description"
    t.integer  "views"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "user_id"
    t.boolean  "open"
    t.string   "slug"
  end

  add_index "competitions", ["slug"], name: "index_competitions_on_slug", using: :btree
  add_index "competitions", ["user_id"], name: "index_competitions_on_user_id", using: :btree

  create_table "contact_messages", force: true do |t|
    t.integer "user_id"
    t.text    "message"
  end

  add_index "contact_messages", ["user_id"], name: "index_contact_messages_on_user_id", using: :btree

  create_table "entries", force: true do |t|
    t.integer  "robot_id"
    t.integer  "competition_id"
    t.integer  "votes"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "user_id"
  end

  add_index "entries", ["user_id"], name: "index_entries_on_user_id", using: :btree

  create_table "friendly_id_slugs", force: true do |t|
    t.string   "slug",                      null: false
    t.integer  "sluggable_id",              null: false
    t.string   "sluggable_type", limit: 50
    t.string   "scope"
    t.datetime "created_at"
  end

  add_index "friendly_id_slugs", ["slug", "sluggable_type", "scope"], name: "index_friendly_id_slugs_on_slug_and_sluggable_type_and_scope", unique: true, using: :btree
  add_index "friendly_id_slugs", ["slug", "sluggable_type"], name: "index_friendly_id_slugs_on_slug_and_sluggable_type", using: :btree
  add_index "friendly_id_slugs", ["sluggable_id"], name: "index_friendly_id_slugs_on_sluggable_id", using: :btree
  add_index "friendly_id_slugs", ["sluggable_type"], name: "index_friendly_id_slugs_on_sluggable_type", using: :btree

  create_table "help_topics", force: true do |t|
    t.string   "title"
    t.text     "body"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "slug"
  end

  add_index "help_topics", ["slug"], name: "index_help_topics_on_slug", using: :btree

  create_table "robots", force: true do |t|
    t.string   "name"
    t.text     "description"
    t.integer  "tier_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "screenshot_url"
    t.integer  "user_id"
    t.integer  "views"
    t.integer  "weapon_id"
    t.string   "slug"
  end

  add_index "robots", ["slug"], name: "index_robots_on_slug", using: :btree
  add_index "robots", ["tier_id"], name: "index_robots_on_tier_id", using: :btree
  add_index "robots", ["user_id"], name: "index_robots_on_user_id", using: :btree
  add_index "robots", ["weapon_id"], name: "index_robots_on_weapon_id", using: :btree

  create_table "tiers", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", force: true do |t|
    t.string   "name"
    t.string   "email"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "password_digest"
    t.string   "remember_token"
    t.boolean  "admin",           default: false
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["remember_token"], name: "index_users_on_remember_token", using: :btree

  create_table "votes", force: true do |t|
    t.integer  "votable_id"
    t.string   "votable_type"
    t.integer  "voter_id"
    t.string   "voter_type"
    t.boolean  "vote_flag"
    t.string   "vote_scope"
    t.integer  "vote_weight"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "votes", ["votable_id", "votable_type", "vote_scope"], name: "index_votes_on_votable_id_and_votable_type_and_vote_scope", using: :btree
  add_index "votes", ["voter_id", "voter_type", "vote_scope"], name: "index_votes_on_voter_id_and_voter_type_and_vote_scope", using: :btree

  create_table "weapons", force: true do |t|
    t.string "name"
    t.string "short_name"
  end

end
