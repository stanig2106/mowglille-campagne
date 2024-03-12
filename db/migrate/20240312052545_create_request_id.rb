class CreateRequestId < ActiveRecord::Migration[7.0]
  def change
    create_table :request_ids do |t|
      t.string :request_id, null: false
      t.timestamps
    end
  end
end
