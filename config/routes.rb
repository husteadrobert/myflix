Myflix::Application.routes.draw do
  get 'ui(/:action)', controller: 'ui'


  root to: 'videos#front'
  resources :videos, only: [:show] do
    collection do
      #get '/search', to: 'videos#search', as: 'search'
      get :search, to: 'videos#search'
    end
  end

  get '/login', to: 'sessions#new', as: 'login'
  post '/login', to: 'sessions#create'

  get '/register', to: 'users#new', as: 'register'
  resources :users, only: [:create]

  get '/home', to: 'videos#index'


  get '/genre/:id', to: 'videos#genre', as: 'genre'
end
