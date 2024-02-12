class AddNameToActivityReward < ActiveRecord::Migration[7.0]
  def change
    add_column :activity_rewards, :name, :string
  end
end
