Rails.application.routes.draw do
  devise_for :users

  resources :polls do
    resources :votes, only: [:new, :create, :show, :index]
  end

  root 'pages#index'
end
