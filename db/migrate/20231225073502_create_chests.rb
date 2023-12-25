class CreateChests < ActiveRecord::Migration[7.0]
  def change
    create_table :chests do |t|
      t.references :user, null: false, foreign_key: true
      t.string :type
      t.integer :amount

      t.timestamps
    end
  end
end
