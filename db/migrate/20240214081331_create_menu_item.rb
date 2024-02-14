class CreateMenuItem < ActiveRecord::Migration[7.0]
  def change
    create_table :menu_items do |t|
      t.string :name
      t.string :type
      t.boolean :vg
      t.string :src
      t.references :event, null: false, foreign_key: true
    end
  end
end
