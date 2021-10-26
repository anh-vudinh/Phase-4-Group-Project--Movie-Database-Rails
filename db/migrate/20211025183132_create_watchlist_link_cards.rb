class CreateWatchlistLinkCards < ActiveRecord::Migration[6.1]
  def change
    create_table :watchlist_link_cards do |t|
      t.belongs_to :watchlist, null: false, foreign_key: true
      t.belongs_to :watchlist_card, null: false, foreign_key: true

      t.timestamps
    end
  end
end
