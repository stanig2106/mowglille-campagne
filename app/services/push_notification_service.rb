require 'firebase-admin-sdk'

class PushNotificationService
  def initialize
    @firebase_push_notification_service = FirebasePushNotificationService.new
    @vapid_push_notification_service = VapidPushNotificationService.new
  end

  def send_notification(user, title, body)
    return if user.subscription == {}

    service = user.subscription.is_a?(String) ?
                @firebase_push_notification_service :
                @vapid_push_notification_service

    service.send_notification(user.subscription, title, body)
  end
end
