Rails.application.routes.draw do
  get 'users/sign_up', to: redirect('users/new')
  devise_for :users
  resources :users
  root 'static_pages#index'
end
