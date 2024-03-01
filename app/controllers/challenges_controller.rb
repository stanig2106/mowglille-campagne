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
        created_at: challenge.created_at,
      }
    end

    render json: { challenges:, categories: }
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
