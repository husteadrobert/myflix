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

  get '/login', to: 'sessions#new', as: 'login'
  post '/login', to: 'sessions#create'
  get '/logout', to: 'sessions#destroy'

  get '/register', to: 'users#new', as: 'register'
  resources :users, only: [:create]
  resources :queue_items, only: [:create, :destroy]
  post 'update_queue', to: 'queue_items#update_queue'


  get '/home', to: 'videos#index'

  get 'my_queue', to: 'queue_items#index'


  get '/genre/:id', to: 'videos#genre', as: 'genre'
end
