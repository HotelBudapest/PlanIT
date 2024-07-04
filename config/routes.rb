Rails.application.routes.draw do
  devise_for :users
  root 'home#index'
  
  resources :events do
    member do
      post 'invite'
    end
    resources :polls, only: [:create, :destroy] do
      resources :poll_options, only: [:new, :create, :edit, :update, :destroy] do
        resources :votes, only: [:create]
      end
    end
    resources :comments, only: [:create]
  end

  resources :users, only: [:show]
end
