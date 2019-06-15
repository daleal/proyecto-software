Rails.application.routes.draw do

  devise_for :users

  resources :moderator_requests

  resources :venues

  resources :courses do
    resources :moderator_requests
  end

  resources :rooms

  resources :events do
    get 'join'
    get 'leave'
    
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

  root 'static_pages#home'
end
