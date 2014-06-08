Rails.application.routes.draw do
  devise_for :users

  resources :polls do
    resources :votes, only: [:new, :create, :show, :index]
  end

  root 'pages#index'
  match '/users/:id', to:  "users#show",
                      via: [:get],
                      as:  'users'
  match '/polls/:poll_id/binned_votes', to:  "votes#binned_votes",
                                        via: [:get],
                                        as:  'binned_votes'
end
