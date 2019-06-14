Rails.application.routes.draw do

  devise_for :users

  resources :moderator_requests

  resources :venues, shallow: true do
    resources :rooms do
      resources :courses do
        resources :moderator_requests
        resources :events
        resources :publications do
          resources :comments
          member do
            put "like" => "publications#upvote"
            put "dislike" => "publications#downvote"
          end
        end
      end
    end
  end

  root 'static_pages#home'
end
