class CreateScoreRecords < ActiveRecord::Migration[7.0]
  def change
    create_table :score_records do |t|
      t.references :user, null: false, foreign_key: true
      t.references :event, null: true, foreign_key: true
      t.references :challenge, null: true, foreign_key: true
      t.references :activity, null: true, foreign_key: true
      t.integer :score
      t.date :date

      t.timestamps
    end
  end
end
