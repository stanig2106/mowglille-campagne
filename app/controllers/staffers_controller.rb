class StaffersController < ApplicationController

  def index
    return not_allowed! unless current_user&.has_staff_role?(:NEW_STAFF)
    render json: { staffers: User.staffers.map { _1.instance_exec {
      { publicToken: public_token, name:, roles: staff_roles.uniq }
    } } }
  end

  def update
    return not_allowed! unless current_user&.has_staff_role?(:NEW_STAFF)
    user = if params[:qr_code].present?
             qr_code = QrCode.extract(params[:qr_code])
             qr_code.user
           else
             User.find_by!(public_token: params[:public_token])
           end
    user.update!(staff_roles: params[:roles].uniq)
    render json: { success: true }
  end

  def offer
    return not_allowed! unless current_user&.has_staff_role?(:CUSTOM_SCORE)

    user = User.find_by!(public_token: params[:user])
    user.score_records.create!(
      reason: params[:reason],
      score: params[:quantity].to_i,
      offered_by: current_user
    )
    params[:chests].each do |chest|
      user.chests.create!(type: chest)
    end

  end

  private

  def not_allowed!
    render json: { error: 'Not authorized' }, status: 401
  end
end
