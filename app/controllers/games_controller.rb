class GamesController < ApplicationController

  def save_score
    user = User.find_by(token: params[:token])

    expected_signature = OpenSSL::HMAC.hexdigest("SHA256",
                                                 "dlqdoqsmdlismqdi",
                                                 params[:data].to_json
    )

    # return a fake success if production
    return render json: { success: Rails.env.production? } \
      unless ActiveSupport::SecurityUtils.secure_compare(expected_signature, params[:f])

    new_score = GameScore.create!(user:,
                                  score: params[:data][:score],
                                  game_name: params[:data][:game_name])

    best = GameScore.find_by(user: user, game_name: params[:data][:game_name], pb: true)
    if best.nil? || best.score < params[:data][:score].to_i
      best&.update!(pb: false)
      new_score.update!(pb: true)
    end

    render json: { success: true }
  end

  def get_scoreboard
    render json: GameScore.get_scoreboard(params[:game_name], current_user).map { {
      **_1, pp: _1[:pp] ? url_for(_1[:pp]) : nil
    } }
  end
end
