class DeleteTypeOnActivity < ActiveRecord::Migration[7.0]
  def change
    remove_column :activities, :type, :string
  end
end
