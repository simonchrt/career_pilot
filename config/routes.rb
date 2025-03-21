Rails.application.routes.draw do
  get 'home/index'
  devise_for :users, controllers: { omniauth_callbacks: 'omniauth_callbacks' }

  root to: 'home#index'

  get "up" => "rails/health#show", as: :rails_health_check

end
