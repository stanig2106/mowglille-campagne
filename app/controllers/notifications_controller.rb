PNS = PushNotificationService.new

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

  def notify
    return render json: { error: 'Not authorized' },
                  status: 401 unless current_user!.has_staff_role?(:NOTIFY)
    return unless params[:type].is_a? String

    if params[:to].present?
      user = User.find_by(public_token: params[:to])
      return unless user
      if user.subscription.nil? || user.notification_preferences.exclude?(params[:type])
        return render json: { error: "L'utilisateur ne peux pas recevoir de notifications" }
      end
      PNS.send_notification(user, params[:title], params[:body])
      return
    end

    User.notifiables(params[:type]).find_each do |user|
      PNS.send_notification(user, params[:title], params[:body])
    end
  end

  def update_status
    current_user!.update!(notification_preferences: params[:notifications])
    render json: { ok: true }
  end
end
