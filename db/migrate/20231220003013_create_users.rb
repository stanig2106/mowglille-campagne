class CreateUsers < ActiveRecord::Migration[7.0]
  def change
    create_table :users do |t|
      t.string :last_name
      t.string :first_name
      t.string :token
    end
  end
end
