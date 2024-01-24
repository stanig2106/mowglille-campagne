class UsersController < ApplicationController
  def check_token
    user = User.find_by(token: params[:token])
    if user
      render json: { ok: true }
    else
      render json: { ok: false }, status: 500
    end
  end

  def cla_login
    info = ClaInfo.create_by_token(params[:ticket])

    cookies[:token] = { value: nil, expires: 1.year.ago }

    return redirect_to root_path if info == nil

    user = info.user
    if user == nil
      user = User.new
      user.cla_info = info
      user.token = SecureRandom.hex(32) + user.id.to_s
      user.public_token = SecureRandom.hex(32) + user.id.to_s
      user.save!
      user
    end

    cookies[:token] = { value: user.token, expires: 1.year.from_now }
    redirect_to root_path
  end

  def show
    user = User.find_by!(token: params[:token])
    render json: user.instance_exec { { id:, public_token:, first_name:, last_name:, score:, rank: } }
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

end
