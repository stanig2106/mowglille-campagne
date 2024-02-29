class RemoveAmountOnChests < ActiveRecord::Migration[7.0]
  def change
    remove_column :chests, :amount, :integer
  end
end
