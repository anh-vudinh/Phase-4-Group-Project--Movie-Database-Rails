class CreateUserResponses < ActiveRecord::Migration[6.1]
  def change
    create_table :user_responses do |t|
      t.references :user, null: false, foreign_key: true
      t.references :response, null: false, foreign_key: true

      t.timestamps
    end
  end
end
