Rails.application.routes.draw do

  resources :venues
  resources :courses

  devise_for :users
  root 'static_pages#home'
end
