class AddCollectionWinnerToUser < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :collection_winner, :boolean, default: false
  end
end
