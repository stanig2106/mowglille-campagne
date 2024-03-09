class AddValidationToChallenge < ActiveRecord::Migration[7.0]
  def change
    add_column :challenges, :validation, :integer, default: 0
  end
end
