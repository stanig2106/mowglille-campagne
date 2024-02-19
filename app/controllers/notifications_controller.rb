class NotificationsController < ApplicationController
  def subscribe
    subscription_p = params[:subscription]

    subscription = if subscription_p.is_a?(String)
                     subscription_p
                   else
                     endpoint = subscription_p[:endpoint]
                     p256dh = subscription_p[:keys][:p256dh]
                     auth = subscription_p[:keys][:auth]
                     { endpoint:, keys: { p256dh:, auth: } }
                   end

    current_user!.update!(subscription:)
    render json: { ok: true }
  end
end
