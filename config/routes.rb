Rails.application.routes.draw do
  devise_for :users, controllers: { omniauth_callbacks: 'omniauth_callbacks' }

  # Page d'accueil et tableau de bord
  root to: 'dashboard#index'
  get 'dashboard', to: 'dashboard#index'

  # Routes des modèles principaux
  resources :companies
  resources :job_listings

  resources :applications do
    resources :application_steps, only: [:create, :update, :destroy]
  end

  resources :technologies

  # Route pour créer une candidature à partir d'une offre d'emploi
  get 'job_listings/:job_listing_id/apply', to: 'applications#new', as: 'new_job_application'
end
