class RemoveDefaultOfSubscriptionOnUser < ActiveRecord::Migration[7.0]
  def change
    change_column_default :users, :subscription, from: {}, to: nil
  end
end
