Rails.application.routes.draw do
  devise_for :users,
    controllers: {
      confirmations: 'confirmations',
      passwords: 'passwords',
      registrations: 'registrations',
      sessions: 'sessions',
    }

  # Ping to ensure site is up
  resources :ping, only: [:index] do
    collection do
      get :auth
    end
  end
  
  namespace :api do
    namespace :v1 do
      resources :posts do
        resources :comments
        resources :likes
      end
      resources :users do
        resource :profile
        resource :relationships, only: %i[create destroy]
        member do
          get :following
          get :followers
        end
      end
    end
  end
end
