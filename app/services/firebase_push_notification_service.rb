require 'firebase-admin-sdk'

class FirebasePushNotificationService
  def initialize
    creds = Firebase::Admin::Credentials.from_json(ENV['FIREBASE_CREDENTIALS'] ||
                                                     File.read('config/firebase-credentials.json'))

    @fcm = Firebase::Admin::App.new(credentials: creds)
  end

  def send_notification(device_token, title, body)
    # Création d'une instance de Message
    message = Firebase::Admin::Messaging::Message.new(
      token: device_token,
      notification: Firebase::Admin::Messaging::Notification.new(
        title: title,
        body: body
      )
    # Vous pouvez également ajouter d'autres configurations ici comme android, apns, etc.
    )

    # Envoi de la notification
    response = @fcm.messaging.send_one(message)

  end
end
