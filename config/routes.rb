Rails.application.routes.draw do
  devise_for :users
  root 'home#index'
  
  resources :events do
    member do
      post 'invite'
    end
    resources :polls do
      resources :votes
    end
    resources :comments
  end

  resources :users, only: [:show]
end
