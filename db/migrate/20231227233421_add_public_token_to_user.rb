class AddPublicTokenToUser < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :public_token, :string
  end
end
