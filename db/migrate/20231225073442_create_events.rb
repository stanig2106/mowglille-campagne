class CreateEvents < ActiveRecord::Migration[7.0]
  def change
    create_table :events do |t|
      t.string :internal_id
      t.string :name
      t.string :type
      t.date :start_date
      t.date :end_date
      t.string :location
      t.text :description

      t.timestamps
    end
  end
end
