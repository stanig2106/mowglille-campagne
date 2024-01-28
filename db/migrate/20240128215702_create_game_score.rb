class CreateGameScore < ActiveRecord::Migration[7.0]
  def change
    create_table :game_scores do |t|
      t.references :user, null: false, foreign_key: true
      t.string :game_name, null: false
      t.integer :score, null: false
      t.boolean :pb, null: false, default: false

      t.timestamps
    end
  end
end
