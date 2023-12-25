class ScoreboardController < ApplicationController
  def get_scoreboard
    render json: { scoreboard: User.scoreboard }
  end
end
