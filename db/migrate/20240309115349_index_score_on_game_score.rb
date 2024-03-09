class IndexScoreOnGameScore < ActiveRecord::Migration[7.0]
  def change
    add_index :game_scores, :score
    add_index :game_scores, :pb
    add_index :game_scores, :game_name
    add_index :congratulations, :reason

    add_column :game_scores, :tries, :integer
    add_column :game_scores, :average, :float
  end
end
