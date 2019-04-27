Rails.application.routes.draw do

  devise_for :users

  resources :venues

  resources :courses

  resources :events

  resources :rooms

  root 'static_pages#home'
end
