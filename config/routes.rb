Rails.application.routes.draw do
  get 'users/sign_up', to: redirect('users/new')
  devise_for :users
  resources  :users
  resources  :friend_requests, only: [:index, :create, :update, :destroy]
  resources  :posts,           only: [:index, :new,    :create]
  resources  :likes,           only: [:create, :destroy]
  resources  :comments,        only: [:create]
  root 'static_pages#index'
end
