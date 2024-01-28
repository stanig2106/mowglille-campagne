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

    GameScore.create!(user:,
                        score: params[:data][:score],
                        game_name: params[:data][:game_name])

    render json: { success: true }

  end
end
