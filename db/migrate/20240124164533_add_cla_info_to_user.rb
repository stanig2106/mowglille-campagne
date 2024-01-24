class AddClaInfoToUser < ActiveRecord::Migration[7.0]
  def change
    remove_column :users, :first_name
    remove_column :users, :last_name

    create_table :cla_infos do |t|
      t.string :username
      t.string :first_name
      t.string :last_name
      t.string :school_email
      t.string :cursus
      t.string :promo
    end

    add_reference :users, :cla_info, foreign_key: true
  end
end
