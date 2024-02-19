class AddSubscriptionToUser < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :subscription, :jsonb, default: {}
  end
end
