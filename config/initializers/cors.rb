Rails.application.config.middleware.insert_before 0, Rack::Cors do
  allow do
    origins 'localhost:3005'
    resource '*',
             headers: :any,
             methods: [:get, :post, :put, :delete, :options]
  end
end if Rails.env.development?
