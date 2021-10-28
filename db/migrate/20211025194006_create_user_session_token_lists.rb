class CreateUserSessionTokenLists < ActiveRecord::Migration[6.1]
  def change
    create_table :user_session_token_lists do |t|
      t.string :session_token
      t.integer :session_duration
      t.datetime :exp_end
      t.belongs_to :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
