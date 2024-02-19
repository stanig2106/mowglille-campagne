class CreateCongratulation < ActiveRecord::Migration[7.0]
  def change
    create_table :congratulations do |t|
      t.references :user, null: false, foreign_key: true
      t.string :reason
      t.references :target, null: false, foreign_key: { to_table: :users }
    end
  end
end
