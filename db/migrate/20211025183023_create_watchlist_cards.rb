class CreateWatchlistCards < ActiveRecord::Migration[6.1]
  def change
    create_table :watchlist_cards do |t|
      t.integer :movie_id
      t.string :movie_name
      t.string :movie_year
      t.float :movie_rating
      t.string :movie_backdrop

      t.timestamps
    end
  end
end
