class CreateUserReviews < ActiveRecord::Migration[6.1]
  def change
    create_table :user_reviews do |t|
      t.belongs_to :user, null: false, foreign_key: true
      t.belongs_to :review, null: false, foreign_key: true

      t.timestamps
    end
  end
end
