class QrCode < ApplicationRecord
  belongs_to :user

  def self.generate(user)
    QrCode.create!(user: user, token: SecureRandom.hex(16))
  end

  def to_web
    token + "&" +
      user.id.to_s + "&" +
      user.public_token + "&" +
      user.first_name.gsub("&", "") + "&" +
      user.last_name.gsub("&", "") + "&" +
      user.score.to_s + "&" +
      user.cursus + "&" +
      created_at.iso8601
  end

  def self.extract(web_qr_code)
    # Offline qr code /!\
    offline_qr = web_qr_code.start_with?("&")
    web_qr_code = web_qr_code[1..] if offline_qr

    token, user_id, public_token, * = web_qr_code.split("&")

    qr_code = QrCode.find_by(token:)
    offline_qr = false if qr_code

    if offline_qr
      raise InvalidQrCode unless (user = User.find_by(id: user_id, public_token:))

      QrCode.create!(user:, token:, count: 1, offline: true)
    else
      qr_code.increment!(:count)
      raise InvalidQrCode unless qr_code.to_web == web_qr_code
      qr_code
    end
  end
end

class InvalidQrCode < StandardError

end
