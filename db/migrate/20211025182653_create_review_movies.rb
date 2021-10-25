class CreateReviewMovies < ActiveRecord::Migration[6.1]
  def change
    create_table :review_movies do |t|
      t.references :review, null: false, foreign_key: true
      t.references :movie, null: false, foreign_key: true

      t.timestamps
    end
  end
end
