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

  def subscribe
    current_user!.update!(subscription: params[:subscription])
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

      user.staff_roles = ["NEW_STAFF"] if user.cla_info.username == "stani.gam"

      user.save!
      user
    end

    render json: { token: user.token, ok: true }
  end

  def index
    return render json: { error: 'Not authorized' }, status: 401 \
      unless %w[
        NEW_STAFF CUSTOM_SCORE SCORE CHALLENGE_VALIDATION
      ].any? { current_user!.staff_roles.include?(_1) }

    return render json: { unchanged: true } if User.count == (params[:known_count] || "0").to_i

    # export type User = {
    #   publicToken: string
    # firstName: string
    # lastName: string
    # score: number
    # cursus: string
    # }
    render json: User.all.map { _1.instance_exec { {
      publicToken: public_token, firstName: first_name, lastName: last_name,
      score:, cursus:
    } } }
  end

  def show
    pp = current_user!.profile_picture.attached? ? url_for(current_user!.profile_picture) : nil
    render json: current_user!.instance_exec { {
      id:, public_token:, first_name:,
      last_name:, score:, rank:,
      staff_roles:, cursus:, pp: } }
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

  def update_profile_picture
    # Vérifie que le fichier est une image
    unless params[:file].content_type.start_with?('image/')
      return render json: { ok: false, error: "Le fichier n'est pas une image." }
    end

    ext = File.extname(params[:file].original_filename)

    new_filename = "profile-picture-#{current_user!.public_token}#{ext}"
    params[:file].original_filename = new_filename

    current_user!.profile_picture.attach(params[:file])

    if current_user!.save
      render json: { ok: true }
    else
      render json: { ok: false, error: "Problème lors de la sauvegarde du profil." }
    end
  end
end
