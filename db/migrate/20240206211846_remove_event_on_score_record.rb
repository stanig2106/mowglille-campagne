class RemoveEventOnScoreRecord < ActiveRecord::Migration[7.0]
  def change
    remove_reference :score_records, :event, null: false, foreign_key: true
    add_column :score_records, :reason, :string
    add_reference :score_records, :offered_by, null: true, foreign_key: { to_table: :users }
  end
end
