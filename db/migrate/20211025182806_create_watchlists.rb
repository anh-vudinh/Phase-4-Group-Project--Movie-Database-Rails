class CreateWatchlists < ActiveRecord::Migration[6.1]
  def change
    create_table :watchlists do |t|
      t.string :wlname
      t.boolean :is_default
      t.belongs_to :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
