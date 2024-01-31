class ApplicationController < ActionController::Base
  skip_before_action :verify_authenticity_token

  # ActionCable.server.broadcast 'notification_channel', 'Votre message ici'

  def current_user
    return nil if params[:token].nil?
    @current_user ||= User.find_by(token: params[:token])
  end
end
