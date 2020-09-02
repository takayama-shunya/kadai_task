Rails.application.routes.draw do

  root to: 'sessions#new'

  resources :sessions, only: %i[ new create destroy ]

  resources :users
    namespace :admin do
      resources :users
    end

  resources :tasks do
    collection do
      post :confirm
    end
  end

end
