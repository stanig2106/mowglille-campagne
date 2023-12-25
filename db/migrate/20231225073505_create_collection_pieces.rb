class CreateCollectionPieces < ActiveRecord::Migration[7.0]
  def change
    create_table :collection_pieces do |t|
      t.integer :number
      t.string :name
      t.string :rarity

      t.timestamps
    end
  end
end
