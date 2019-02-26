Rails.application.routes.draw do
  devise_for :users

  root to: 'pages#home'

  resources :events, only: [:show, :new, :create, :edit, :update]

  resources :participations, only: [:index] do
    scope module: :participations do
      resources :accepteds, only: :create
      resources :declineds, only: :create
    end
    resources :votes, only: :create
  end

end

