class UsersController < ApplicationController
  def check_token
    user = User.find_by(token: params[:token])
    if user
      puts "User #{user.id} is connected"
      render json: { ok: true }
    else
      puts "User not found"
      render json: { ok: false }
    end
  end

  def cla_login
    info = ClaInfo.create_by_token(params[:ticket])

    return render json: { error: 'Unknown token', ok: false } if info == nil

    user = info.user
    if user == nil
      user = User.new
      user.cla_info = info
      user.token = SecureRandom.hex(32) + user.id.to_s
      user.public_token = SecureRandom.hex(32) + user.id.to_s
      user.save!
      user
    end

    render json: { token: user.token, ok: true }
  end

  def index
    render json: User.all.map { _1.instance_exec { { public_token:, name:, cursus: } } }
  end

  def show
    user = User.find_by!(token: params[:token])
    render json: user.instance_exec { { id:, public_token:, first_name:, last_name:, score:, rank:, staff_roles:, cursus: } }
  end

  def qr_code
    user = User.find_by!(token: params[:token])
    qr_code = QrCode.generate(user)

    render json: { content: qr_code.to_web }
  end

  def check_qr_code
    return render json: {
      error: 'Le QR code est invalide, veuillez en générer un nouveau',
    } unless QrCode.is_valid(params[:content])

    render json: { ok: true }

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
