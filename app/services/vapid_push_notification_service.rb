require 'web-push'

class VapidPushNotificationService
  def initialize
    @vapid_key = {
      subject: 'mailto:stanig2106@gmail.com',
      public_key: ENV['VAPID_PUBLIC_KEY'],
      private_key: ENV['VAPID_PRIVATE_KEY']
    }
  end

  def send_notification(subscription, title, body, data = {})
    WebPush.payload_send(
      message: JSON.generate({
                               **data,
                               type: 'notification',
                               title:, body:,
                             }),
      endpoint: subscription["endpoint"],
      p256dh: subscription["keys"]["p256dh"],
      auth: subscription["keys"]["auth"],
      vapid: @vapid_key
    )
  end
end
