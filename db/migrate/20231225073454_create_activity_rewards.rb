class CreateActivityRewards < ActiveRecord::Migration[7.0]
  def change
    create_table :activity_rewards do |t|
      t.references :activity, null: false, foreign_key: true
      t.integer :score
      t.string :chest

      t.timestamps
    end
  end
end
