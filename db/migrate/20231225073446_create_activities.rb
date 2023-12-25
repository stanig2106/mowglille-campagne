class CreateActivities < ActiveRecord::Migration[7.0]
  def change
    create_table :activities do |t|
      t.string :internal_id
      t.string :name
      t.text :description
      t.date :start_date
      t.date :end_date
      t.string :location
      t.string :type
      t.references :event, null: false, foreign_key: true

      t.timestamps
    end
  end
end
