class AddNotificationPreferencesToUser < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :notification_preferences, :string, array: true
  end
end
