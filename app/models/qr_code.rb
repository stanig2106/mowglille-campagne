class QrCode < ApplicationRecord
  belongs_to :user

  def self.generate(user)
    QrCode.create(user: user, token: SecureRandom.hex(16))
  end

  def to_web
    token + "&" +
      user.id.to_s + "&" +
      user.public_token + "&" +
      user.first_name.gsub("&", "") + "&" +
      user.last_name.gsub("&", "") + "&" +
      user.score.to_s + "&" +
      created_at.iso8601
  end
end
