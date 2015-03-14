Myflix::Application.routes.draw do
  root to: 'pages#front'
  get 'ui(/:action)', controller: 'ui'
  get '/home', to: "videos#index"
  get 'register', to: 'users#new'
  get '/login', to: 'sessions#new'

  resources :videos, only: [:show] do
    collection do
      post :search, to: "videos#search"
    end
  end
  resources :categories, only: [:show]
  
end
