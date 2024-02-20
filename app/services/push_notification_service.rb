require 'firebase-admin-sdk'

class PushNotificationService
  def initialize
    @firebase_push_notification_service = FirebasePushNotificationService.new
    @vapid_push_notification_service = VapidPushNotificationService.new
  end

  def send_notification(user, title, body)
    s = JSON.parse(user.subscription) rescue user.subscription
    return if s.nil? || s.empty?

    service = s.is_a?(String) ?
                @firebase_push_notification_service :
                @vapid_push_notification_service

    service.send_notification(s, title, body)
  end
end
