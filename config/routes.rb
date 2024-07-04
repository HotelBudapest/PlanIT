Rails.application.routes.draw do
  devise_for :users
  root 'home#index'
  
  resources :events do
    member do
      post 'invite'
    end
    resources :polls, only: [:create, :destroy] do
      resources :poll_options, only: [:new, :create] do
        resources :votes, only: [:create]
      end
    end
  end

  resources :users, only: [:show]
end
