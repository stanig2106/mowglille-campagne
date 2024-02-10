class CreatePlanningAssociation < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :planning_letter, :string

    create_table :planning_urls do |t|
      t.string :url
    end
  end
end
