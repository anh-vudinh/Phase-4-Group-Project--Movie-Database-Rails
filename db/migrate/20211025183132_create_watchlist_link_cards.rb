class CreateWatchlistLinkCards < ActiveRecord::Migration[6.1]
  def change
    create_table :watchlist_link_cards do |t|
      t.references :watchlist, null: false, foreign_key: true
      t.references :watchlist_card, null: false, foreign_key: true

      t.timestamps
    end
  end
end
