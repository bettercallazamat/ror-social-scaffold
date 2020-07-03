Rails.application.routes.draw do

  root 'posts#index'

  devise_for :users

  resources :users, only: [:index, :show]
  resources :posts, only: [:index, :create] do
    resources :comments, only: [:create]
    resources :likes, only: [:create, :destroy]
  end

  post 'user/:id/friendship', to: 'friendships#create', as: 'new_friendship'
  put '/user/:id/friendship', to: 'friendships#update', as: 'friendship'
  delete '/user/:id/friendship', to: 'friendships#destroy', as: 'unfriendship'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
