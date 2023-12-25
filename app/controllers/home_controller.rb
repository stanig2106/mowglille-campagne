class HomeController < ApplicationController
  def index
    html_content = File.read('public/index.html')

    updated_html = html_content.gsub('!!CSRF-TOKEN!!', form_authenticity_token)

    render html: updated_html.html_safe
  end

  def assetlinks
    render file: 'public/assetlinks.json'
  end

  def not_found_api
    render json: { error: 'Not found' }, status: 404
  end
end
