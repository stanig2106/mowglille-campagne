class HomeController < ApplicationController
  def index
    render file: 'public/index.html'
  end

  LOGIN_DEST = "https://pwa.mowglille.fr/cla_login"

  def cla_login
    return redirect_to root_path if params[:ticket] == nil

    redirect_to "#{LOGIN_DEST}?ticket=#{params[:ticket]}", allow_other_host: true
  end
end
