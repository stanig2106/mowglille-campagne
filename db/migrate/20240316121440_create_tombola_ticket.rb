class CreateTombolaTicket < ActiveRecord::Migration[7.0]
  def change
    create_table :tombola_tickets do |t|
      t.belongs_to :user
    end
  end
end
