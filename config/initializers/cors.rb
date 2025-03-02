# config/initializers/cors.rb

Rails.application.config.middleware.insert_before 0, Rack::Cors do
  allow do
    origins "https://grain-menu-app.fly.dev", "http://localhost:8080"
    resource "*", headers: :any, methods: [ :post, :options ]
  end
end
