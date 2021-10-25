class CreateReviews < ActiveRecord::Migration[6.1]
  def change
    create_table :reviews do |t|
      t.string :author
      t.string :content
      t.string :username
      t.string :avatar_path
      t.integer :rating

      t.timestamps
    end
  end
end
