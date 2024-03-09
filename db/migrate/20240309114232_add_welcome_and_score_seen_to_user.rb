class AddWelcomeAndScoreSeenToUser < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :welcomed, :boolean, default: false
    add_column :users, :score_seen, :boolean, default: false
    add_column :users, :fullscreen_msg, :string
  end
end
