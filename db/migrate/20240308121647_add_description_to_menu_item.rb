class AddDescriptionToMenuItem < ActiveRecord::Migration[7.0]
  def change
    add_column :menu_items, :description, :text
  end
end
