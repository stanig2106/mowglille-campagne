require 'net/http'
require 'uri'

class ClaInfo < ApplicationRecord
  has_one :user, dependent: :destroy

  CLA_HOST = "https://centralelilleassos.fr"
  CLA_AUTH_IDENTIFIER = "mowglille"

  def self.create_by_token(token)
    return nil unless token

    token = URI.encode_www_form_component(token)

    path = "/authentification/#{CLA_AUTH_IDENTIFIER}/#{token}"

    begin
      puts "Requesting #{CLA_HOST}#{path}"
      response = Net::HTTP.get(CLA_HOST, path)
      puts response

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
    rescue StandardError => e
      puts e
      return nil
    end
  end
end
