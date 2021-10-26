class CreateMovies < ActiveRecord::Migration[6.1]
  def change
    create_table :movies do |t|
      t.integer :movie_id
      t.string :movie_name

      t.timestamps
    end
  end
end
