Rails.application.routes.draw do

  devise_for :users

  get 'rooms/catalog', to: 'rooms#catalog'
  get 'courses/catalog', to: 'courses#catalog'
  get 'events/catalog', to: 'events#catalog'
  get 'publications/catalog', to: 'publications#catalog'

  resources :venues, shallow: true do

    resources :rooms do

      resources :courses do
        resources :moderator_requests

        resources :events do
          get 'join'
          get 'leave'
        end

        resources :publications do
          member do
            put "like" => "publications#upvote"
            put "dislike" => "publications#downvote"
          end

          resources :comments do
            member do
              put "like" => "comments#upvote"
              put "dislike" => "comments#downvote"
            end
          end
        end
      end
    end
  end

  resources :conversations do
    resources :messages
  end

  root 'static_pages#home'
end
