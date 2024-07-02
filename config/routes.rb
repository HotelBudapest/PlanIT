Rails.application.routes.draw do
  devise_for :users
  root 'home#index'
  
  resources :events do
    resources :polls do
      resources :votes, only: [:create, :destroy]
    end
    resources :comments, only: [:create, :destroy]
  end

  resources :users, only: [:show]
end
