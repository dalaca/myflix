Myflix::Application.routes.draw do
  root to: 'pages#front'
  get 'ui(/:action)', controller: 'ui'
  get '/home', to: "videos#index"
  get '/register', to: 'users#new'
  get '/login', to: 'sessions#new'
  get '/home', to: 'videos#index'
  get '/sign_in', to: 'sessions#create'
  get '/sign_out', to: 'sessions#destroy'

  resources :videos, only: [:show] do
    collection do
      post :search, to: "videos#search"
    end
    resources :reviews, only: [:create]
  end
  resources :queue_items, only: [:create, :destroy]
  post 'update_queue', to: 'queue_items#update_queue'
  get 'my_queue', to: 'queue_items#index'

  resources :categories, only: [:show]
  resources :sessions, only: [:create]
  resources :users
end
