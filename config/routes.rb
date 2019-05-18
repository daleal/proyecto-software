Rails.application.routes.draw do

  get 'moderator_request/new'

  get 'moderator_request/create'

  get 'moderator_request/edit'

  get 'moderator_request/update'

  get 'moderator_request/show'

  get 'moderator_request/index'

  get 'moderator_request/destroy'

  devise_for :users

  resources :venues

  resources :courses do
    resources :moderator_requests
  end

  resources :events

  resources :rooms

  resources :publications do
    resources :comments
  end

  root 'static_pages#home'
end
