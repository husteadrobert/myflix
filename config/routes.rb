Myflix::Application.routes.draw do
  get 'ui(/:action)', controller: 'ui'
  root to: 'videos#index'
  resources :videos, only: [:show] do
    collection do
      #get '/search', to: 'videos#search', as: 'search'
      get :search, to: 'videos#search'
    end
  end

  get '/home', to: 'videos#index'

  #get '/video/:id', to: 'videos#show', as: 'video'

  get '/genre/:id', to: 'videos#genre', as: 'genre'

  #get '/videos/search', to: 'videos#search', as: 'search'
end
