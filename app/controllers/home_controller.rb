class HomeController < ApplicationController
  def index
    render file: 'public/index.html'
  end

  def assetlinks
    render file: 'public/assetlinks.json'
  end

  def not_found_api
    render json: { error: 'Not found' }, status: 404
  end

  def version
    render json: { version: BUILD_ID }
  end
end
