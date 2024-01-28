require 'net/http'
require 'uri'

class ClaInfo < ApplicationRecord
  has_one :user, dependent: :destroy

  CLA_HOST = "centralelilleassos.fr"
  CLA_AUTH_IDENTIFIER = "mowglille"

  def self.create_by_token(token)
    return nil unless token

    token = URI.encode_www_form_component(token)

    url = "https://#{CLA_HOST}/authentification/#{CLA_AUTH_IDENTIFIER}/#{token}"

    response = Net::HTTP.get(URI(url))

    json = JSON.parse(response)
    puts json
    return nil unless json['success']

    cla_info = ClaInfo.find_or_initialize_by(username: json['username'])
    return cla_info unless cla_info.new_record?

    payload = json["payload"]

    cla_info.username = payload["username"]
    cla_info.school_email = payload["emailSchool"]
    cla_info.first_name = payload["firstName"]
    cla_info.last_name = payload["lastName"]
    cla_info.cursus = payload["cursus"]
    cla_info.promo = payload["promo"]

    cla_info.save!
    return cla_info
  end
end
