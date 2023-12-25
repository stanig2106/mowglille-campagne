class UsersController < ApplicationController
  def create
    user = User.create!(user_params)
    user.token = SecureRandom.hex(32) + user.id.to_s
    user.save!


    render json: { token: user.token }
  end

  def qr_code
    user = User.find_by!(token: params[:token])
    qr_code = QrCode.generate(user)

    render json: { content: qr_code.to_web }
  end

  def score
    user = User.find_by!(token: params[:token])
    render json: { score: user.score }
  end

  def rank
    user = User.find_by!(token: params[:token])
    render json: { rank: user.rank }
  end

  def name
    user = User.find_by!(token: params[:token])
    render json: { name: user.name }
  end

  private

  def user_params
    params.permit(:last_name, :first_name)
  end
end
