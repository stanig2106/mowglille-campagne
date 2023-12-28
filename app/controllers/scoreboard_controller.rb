class ScoreboardController < ApplicationController
  def get_scoreboard
    render json: { scoreboard: User.scoreboard }
  end

  def get_score_details
    # TODO !
    user = User.find_by!(token: params[:token])
    render json: { score_details: [] }
  end
end
