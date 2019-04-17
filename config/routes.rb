Rails.application.routes.draw do

  resources :venues

  resources :rooms

  resources :courses

  devise_for :users
  root 'static_pages#home'
end
