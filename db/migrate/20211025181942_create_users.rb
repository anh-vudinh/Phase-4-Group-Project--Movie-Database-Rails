class CreateUsers < ActiveRecord::Migration[6.1]
  def change
    create_table :users do |t|
      t.string :username
      t.string :useremail
      t.string :password_digest
      t.boolean :is_admin
      t.boolean :account_active
      t.string :avatar_path

      t.timestamps
    end
  end
end
