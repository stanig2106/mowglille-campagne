class HomeController < ApplicationController
  def index
    cookies[:csrf_token] = form_authenticity_token
    render file: 'public/index.html'
  end

  def assetlinks
    render file: 'public/assetlinks.json'
  end

  def not_found_api
    render json: { error: 'Not found' }, status: 404
  end
end
