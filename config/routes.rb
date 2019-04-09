Rails.application.routes.draw do
  resources :courses

  devise_for :users
  root 'static_pages#home'
end
