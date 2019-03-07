Rails.application.routes.draw do
  devise_for :users, controllers: { omniauth_callbacks: 'users/omniauth_callbacks' }

  root to: 'participations#index'

  resources :events, param: :slug, only: [:show, :new, :create, :edit, :update] do
    scope module: :events do
      resources :statuses, param: :slug, only: :update
    end
  end

  resources :participations, only: [:index] do
    scope module: :participations do
      resources :accepteds, only: :create
      resources :declineds, only: :create
    end
    resources :votes, only: :create
  end

end

