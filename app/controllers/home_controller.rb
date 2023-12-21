class HomeController < ApplicationController
  def index
    cookies[:csrf_token] = form_authenticity_token
    render file: 'public/index.html'
  end
end
