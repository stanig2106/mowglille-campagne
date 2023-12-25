class CreateChallenges < ActiveRecord::Migration[7.0]
  def change
    create_table :challenges do |t|
      t.string :internal_id
      t.string :name
      t.text :description
      t.integer :score
      t.date :start_date
      t.date :end_date
      t.string :location
      t.integer :amount

      t.timestamps
    end
  end
end
