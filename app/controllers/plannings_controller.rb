class PlanningsController < ApplicationController
  def get_planning

  end

  def update_planning_link
    return render json: { error: 'Not authorized' }, status: 401 unless current_user&.has_staff_role?(:MANAGE_PLANNING)

    PlanningUrl.set(params[:link])
    render json: { success: true }
  end

  def manage_planning
    return render json: { error: 'Not authorized' }, status: 401 unless current_user&.has_staff_role?(:MANAGE_PLANNING)

    render json: {
      sheet_link: PlanningUrl.get,
      associations: User.where.not(planning_letter: nil).map { |user| { name: user.name, letter: user.planning_letter } }
    }
  end

  def set_planning_association
    return render json: { error: 'Not authorized' }, status: 401 unless current_user&.has_staff_role?(:MANAGE_PLANNING)

    user = User.find_by!(public_token: params[:public_token])
    user.update!(planning_letter: params[:letter])
    render json: { success: true }
  end

  def delete_planning_association
    return render json: { error: 'Not authorized' }, status: 401 unless current_user&.has_staff_role?(:MANAGE_PLANNING)

    user = User.find_by!(planning_letter: params[:letter])
    user.update!(planning_letter: nil)
    render json: { success: true }
  end

end
