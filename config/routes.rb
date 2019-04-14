Rails.application.routes.draw do
  get 'rooms/create'

  get 'rooms/destroy'

  get 'rooms/update'

  get 'rooms/index'

  get 'rooms/show'

  get 'rooms/new'

  get 'rooms/edit'

  resources :courses

  devise_for :users
  root 'static_pages#home'
end
