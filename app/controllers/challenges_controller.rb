class ChallengesController < ApplicationController
  def create
    return not_allowed! unless current_user&.has_staff_role?(:CHALLENGE_MANAGE)

    p = {
      category: params[:category],
      name: params[:name],
      description: params[:description],
      score: params[:score],
      is_flash: params[:category] == 'flash',
      start_date: params[:start_date],
      end_date: params[:end_date],
      amount: params[:amount]
    }

    if params[:id]
      challenge = Challenge.find(params[:id])
      challenge.update!(**p)
      return render json: { ok: true }
    end

    Challenge.create!(**p)

    render json: { ok: true }
  end

  def index
    categories = Challenge.all.map(&:category).uniq
    challenges = Challenge.all.map do |challenge|
      {
        id: challenge.id,
        category: challenge.category,
        name: challenge.name,
        description: challenge.description,
        score: challenge.score,
        is_flash: challenge.is_flash,
        start_date: challenge.start_date,
        end_date: challenge.end_date,
        amount: challenge.amount,
        validation: challenge.validation,
        created_at: challenge.created_at,
        validated: ChallengeValidation
                    .where(challenge: challenge, user: current_user).exists?
      }
    end

    render json: { challenges:, categories: }
  end

  def validate
    return not_allowed! unless current_user&.has_staff_role?(:CHALLENGE_VALIDATION)
    c = Challenge.find(params[:id])

    user = User.find_by!(public_token: params[:user])
    if c.amount && c.amount <= c.validation
      return render json: { error: 'Trop de joueurs ont deja valider ce défis' }
    end
    if ChallengeValidation.find_by(challenge: c, user:)
      return render json: { error: 'Ce défi à déjà été validé' }
    end

    c.increment! :validation

    user.score_records.create!(
      reason: "Vous avez fait le défis " + c.name,
      score: c.score,
      offered_by: current_user!
    )
    ChallengeValidation.create!(
      challenge: c,
      user: user,
    )

    user.chests.create!(type: "rare") if c.name == "Soutien actif"
    p c.name

    render json: { ok: true }

  end

  def destroy
    return not_allowed! unless current_user&.has_staff_role?(:CHALLENGE_MANAGE)
    Challenge.find(params[:id]).destroy!
    render json: { ok: true }
  end

  private

  def not_allowed!
    render json: { error: 'Not authorized' }, status: 401
  end

end
