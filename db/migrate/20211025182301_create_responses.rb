class CreateResponses < ActiveRecord::Migration[6.1]
  def change
    create_table :responses do |t|
      t.string :author
      t.string :content
      t.string :username
      t.string :avatar_path

      t.timestamps
    end
  end
end
