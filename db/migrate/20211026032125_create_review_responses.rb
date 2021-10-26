class CreateReviewResponses < ActiveRecord::Migration[6.1]
  def change
    create_table :review_responses do |t|
      t.belongs_to :review, null: true
      t.belongs_to :response, null: true

      t.timestamps
    end
  end
end
