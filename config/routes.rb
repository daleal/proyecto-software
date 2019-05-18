Rails.application.routes.draw do

  devise_for :users

  resources :moderator_requests

  resources :venues

  resources :courses do
    resources :moderator_requests
  end

  resources :rooms

  resources :events do
    resources :publications do
      resources :comments
    end
  end

  root 'static_pages#home'
end
