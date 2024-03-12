class ApplicationController < ActionController::Base
  skip_before_action :verify_authenticity_token
  before_action :verify_request_id

  # ActionCable.server.broadcast 'NotificationChannel', 'Votre message ici'

  def verify_request_id
    RequestId.where("created_at < ?", 1.hour.ago).delete_all
    if params[:request_id]
      return render json: { error: "Request ID already used" } \
        if RequestId.find_by(request_id: params[:request_id])
      RequestId.create!(request_id: params[:request_id])
    end
  end

  def current_user!
    raise "Not logged in" unless params[:token]
    @current_user ||= User.find_by!(token: params[:token])
  end

  def current_user
    return nil if params[:token].nil?
    @current_user ||= User.find_by!(token: params[:token])
  end
end
