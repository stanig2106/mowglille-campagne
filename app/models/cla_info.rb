require 'net/http'
require 'uri'

class ClaInfo < ApplicationRecord
  has_one :user, dependent: :destroy

  CLA_HOST = "centralelilleassos.fr"
  CLA_AUTH_IDENTIFIER = "mowglille"

  def self.create_by_token(token)
    return nil unless token

    url = "https://#{CLA_HOST}/authentification/#{CLA_AUTH_IDENTIFIER}/#{token}"

    begin
      response = Net::HTTP.get(URI(url))

      json = JSON.parse(response)
      return nil unless json['success']

      cla_info = ClaInfo.find_or_initialize_by(username: json['username'])
      return cla_info unless cla_info.new_record?

      %w[first_name last_name school_email cursus promo]
        .each { cla_info.send("#{_1}=", json[_1]) }
      cla_info.save!
      return cla_info
    rescue
      return nil
    end
  end
end
