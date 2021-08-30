Rails.application.routes.draw do
  devise_for :users,
    controllers: {
      confirmations: 'confirmations',
      passwords: 'passwords',
      registrations: 'registrations',
      sessions: 'sessions',
    }

  resources :ping, only: [:index] do
    collection do
      get :auth
    end
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
