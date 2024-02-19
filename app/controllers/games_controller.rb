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
    if best.nil? ||
      (GameScore.inverse_score?(params[:data][:game_name]) ?
         best.score > params[:data][:score].to_f : best.score < params[:data][:score].to_f)
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

  def congratulate
    game_names = {
      human_benchmark_reaction_time: "Temps de réaction",
      human_benchmark_chimp_test: "Test de chimpanzé",
      human_benchmark_sequence_memory: "Mémoire de séquence",
      human_benchmark_aim_trainer: "Entraînement de visée",
      human_benchmark_number_memory: "Mémoire de nombres",
      human_benchmark_verbal_memory: "Mémoire verbale",
      human_benchmark_visual_memory: "Mémoire visuelle",
    }

    score = GameScore.find(params[:score_id])
    Congratulation.find_or_create_by!(
      user: current_user!,
      target: score.user,
      reason: score.game_name
    )
    ScoreRecord.create!(
      user: score.user,
      offered_by: current_user!,
      score: 1,
      reason: "Félicitation pour ton score à #{game_names[score.game_name.to_sym]}"
    )
  end
end

