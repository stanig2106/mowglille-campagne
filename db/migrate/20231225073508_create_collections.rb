class CreateCollections < ActiveRecord::Migration[7.0]
  def change
    create_table :collections do |t|
      t.references :user, null: false, foreign_key: true
      t.references :collection_piece, null: false, foreign_key: true
      t.date :date

      t.timestamps
    end
  end
end
