class Api::UsersController < ApplicationController
  def create
    user = User.create!(user_params)
    user.token = SecureRandom.hex(32) + user.id.to_s
    user.save!


    render json: { token: user.token }
  end

  private

  def user_params
    params.permit(:last_name, :first_name)
  end
end
