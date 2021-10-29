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

ActiveRecord::Schema.define(version: 2021_10_27_183310) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "cpanels", force: :cascade do |t|
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "movies", force: :cascade do |t|
    t.integer "movie_id"
    t.string "movie_name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "responses", force: :cascade do |t|
    t.string "author"
    t.string "content"
    t.string "username"
    t.string "avatar_path"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "review_movies", force: :cascade do |t|
    t.bigint "review_id"
    t.bigint "movie_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["movie_id"], name: "index_review_movies_on_movie_id"
    t.index ["review_id"], name: "index_review_movies_on_review_id"
  end

  create_table "review_responses", force: :cascade do |t|
    t.bigint "review_id"
    t.bigint "response_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["response_id"], name: "index_review_responses_on_response_id"
    t.index ["review_id"], name: "index_review_responses_on_review_id"
  end

  create_table "reviews", force: :cascade do |t|
    t.string "author"
    t.string "content"
    t.string "username"
    t.string "avatar_path"
    t.integer "rating"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "sessions", force: :cascade do |t|
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "user_responses", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "response_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["response_id"], name: "index_user_responses_on_response_id"
    t.index ["user_id"], name: "index_user_responses_on_user_id"
  end

  create_table "user_reviews", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "review_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["review_id"], name: "index_user_reviews_on_review_id"
    t.index ["user_id"], name: "index_user_reviews_on_user_id"
  end

  create_table "user_session_token_lists", force: :cascade do |t|
    t.string "session_token"
    t.integer "session_duration"
    t.datetime "exp_end"
    t.bigint "user_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["user_id"], name: "index_user_session_token_lists_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "username"
    t.string "useremail"
    t.string "password_digest"
    t.boolean "login_status"
    t.boolean "is_admin"
    t.boolean "account_active"
    t.string "avatar_path"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "watchlist_cards", force: :cascade do |t|
    t.integer "movie_id"
    t.string "movie_name"
    t.string "movie_year"
    t.float "movie_rating"
    t.string "movie_backdrop"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "watchlist_link_cards", force: :cascade do |t|
    t.bigint "watchlist_id", null: false
    t.bigint "watchlist_card_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["watchlist_card_id"], name: "index_watchlist_link_cards_on_watchlist_card_id"
    t.index ["watchlist_id"], name: "index_watchlist_link_cards_on_watchlist_id"
  end

  create_table "watchlists", force: :cascade do |t|
    t.string "wlname"
    t.boolean "is_default"
    t.bigint "user_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["user_id"], name: "index_watchlists_on_user_id"
  end

  add_foreign_key "user_responses", "responses"
  add_foreign_key "user_responses", "users"
  add_foreign_key "user_reviews", "reviews"
  add_foreign_key "user_reviews", "users"
  add_foreign_key "user_session_token_lists", "users"
  add_foreign_key "watchlist_link_cards", "watchlist_cards"
  add_foreign_key "watchlist_link_cards", "watchlists"
  add_foreign_key "watchlists", "users"
end
