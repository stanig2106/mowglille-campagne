class ChangeChallenge < ActiveRecord::Migration[7.0]
  def change
    remove_column :challenges, :internal_id, :string
    remove_column :challenges, :location, :string

    add_column :challenges, :category, :string
    add_column :challenges, :is_flash, :boolean
  end
end
