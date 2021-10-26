class CreateReviewMovies < ActiveRecord::Migration[6.1]
  def change
    create_table :review_movies do |t|
      t.belongs_to :review, null: true
      t.belongs_to :movie, null: true

      t.timestamps
    end
  end
end
