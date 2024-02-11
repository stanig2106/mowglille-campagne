class AddInternalDescriptionOnActivities < ActiveRecord::Migration[7.0]
  def change
    add_column :activities, :internal_description, :text
    add_column :activity_rewards, :internal_description, :text
  end
end
