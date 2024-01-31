class StaffersController < ApplicationController
  before_action :require_staffer!

  def index
    render json: { staffers: User.staffers.map { _1.instance_exec {
      { publicToken: public_token, name:, roles: staff_roles.uniq }
    } } }
  end

  def update
    user = if params[:qr_code].present?
             qr_code = QrCode.extract(params[:qr_code])
             qr_code.user
           else
             User.find_by!(public_token: params[:public_token])
           end
    user.update!(staff_roles: params[:roles].uniq)
    render json: { success: true }
  end

  private

  def require_staffer!
    raise "Not a staffer" unless current_user&.has_staff_role?(:NEW_STAFF)
  end
end
