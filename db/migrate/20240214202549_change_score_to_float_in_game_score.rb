class ChangeScoreToFloatInGameScore < ActiveRecord::Migration[7.0]
  def change
    change_column :game_scores, :score, :float
  end
end
