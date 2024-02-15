class ApplicationController < ActionController::Base
  skip_before_action :verify_authenticity_token

  # ActionCable.server.broadcast 'NotificationChannel', 'Votre message ici'

  def current_user!
    raise "Not logged in" unless params[:token]
    @current_user ||= User.find_by!(token: params[:token])
  end

  def current_user
    return nil if params[:token].nil?
    @current_user ||= User.find_by!(token: params[:token])
  end
end
