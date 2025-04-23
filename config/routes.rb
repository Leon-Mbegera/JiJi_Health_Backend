Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # API routess
  namespace :api do
    namespace :v1 do
      # User Authentication Endpoints
      # POST /api/v1/signup - Register a new user
      post 'signup', to: 'registrations#create'

      # POST /api/v1/login - Authenticate user and return token
      post 'login', to: 'sessions#create'

      # DELETE /api/v1/logout - Invalidate token
      delete 'logout', to: 'sessions#destroy'

    end
  end
end
