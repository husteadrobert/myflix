require 'sidekiq/web'

Myflix::Application.routes.draw do
  get 'ui(/:action)', controller: 'ui'


  root to: 'pages#front'
  resources :videos, only: [:show] do
    collection do
      #get '/search', to: 'videos#search', as: 'search'
      get :search, to: 'videos#search'
    end
    # member do
    #   post :review, to: 'videos#review'
    # end
    resources :reviews, only: [:create]
  end

  namespace :admin do
    resources :videos, only: [:new, :create]
  end

  resources :relationships, only: [:create, :destroy]

  get '/login', to: 'sessions#new', as: 'login'
  post '/login', to: 'sessions#create'
  get '/logout', to: 'sessions#destroy'

  get '/register', to: 'users#new', as: 'register'
  resources :users, only: [:create, :show]
  get 'forgot_password', to: 'forgot_passwords#new'
  resources :forgot_passwords, only: [:create]
  get 'forgot_password_confirmation', to: 'forgot_passwords#confirm'
  resources :password_resets, only: [:show, :create]
  get 'expired_token', to: 'pages#expired_token'
  # get '/reset_password', to: 'users#request_reset_password'
  # get '/reset_password/:id', to: 'users#reset_password_form'
  # post '/reset_password', to: 'users#reset_password'

  resources :queue_items, only: [:create, :destroy]
  post 'update_queue', to: 'queue_items#update_queue'

  get '/people', to: 'relationships#index'

  get '/home', to: 'videos#index'

  get 'my_queue', to: 'queue_items#index'

  get '/genre/:id', to: 'videos#genre', as: 'genre'

  resources :invitations, only: [:new, :create]

  get 'register/:token', to: "users#new_with_invitation_token", as: "register_with_token"

  mount Sidekiq::Web => "/sidekiq"
end
