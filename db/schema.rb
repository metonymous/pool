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
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20110518173642) do

  create_table "accounts", :force => true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "pool_miner", :id => false, :force => true do |t|
    t.string "username"
    t.string "password"
  end

  create_table "pool_miners", :force => true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "shares", :id => false, :force => true do |t|
    t.string    "rem_host"
    t.string    "username"
    t.string    "our_result",      :limit => 1
    t.string    "upstream_result", :limit => 1
    t.string    "reason"
    t.string    "solution",        :limit => 512
    t.timestamp "updated_at",                     :null => false
  end

  create_table "users", :force => true do |t|
    t.string   "identity_url"
    t.string   "nickname"
    t.string   "fullname"
    t.string   "email"
    t.string   "address"
    t.string   "url"
    t.string   "public_key"
    t.integer  "account_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
