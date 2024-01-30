class AddStaffRolesToUser < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :staff_roles, :string, array: true, default: []
  end
end
