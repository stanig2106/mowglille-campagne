class ApplicationController < ActionController::Base
  skip_before_action :verify_authenticity_token

  # ActionCable.server.broadcast 'notification_channel', 'Votre message ici'
end
