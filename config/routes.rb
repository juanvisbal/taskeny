Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  root "tasks#index"
  
  # Task resources with nested comments
  resources :tasks do
    resources :comments, only: [:create, :update, :destroy]
    member do
      patch :complete
      patch :uncomplete
      patch :change_priority
      patch :toggle
    end
    collection do
      get :completed
      get :pending
    end
  end
  
  # Project resources
  resources :projects do
    resources :tasks, only: [:index, :new, :create]
    member do
      get :dashboard
    end
  end
  
  # Categories for task organization
  resources :categories
  
  # Tags for flexible task labeling
  resources :tags, except: [:show]
  
  # User profile and settings
  resource :profile, only: [:show, :edit, :update]
  resource :settings, only: [:show, :update]
  
  # Search functionality
  get '/search', to: 'search#index'
  
  # API routes
  namespace :api do
    namespace :v1 do
      resources :tasks, only: [:index, :show, :create, :update, :destroy]
      resources :projects, only: [:index, :show]
    end
  end
  
  # Authentication routes (uncomment when adding authentication)
  # devise_for :users
  # Or for a custom authentication system:
  # get '/login', to: 'sessions#new'
  # post '/login', to: 'sessions#create'
  # delete '/logout', to: 'sessions#destroy'
  # get '/signup', to: 'users#new'
  # post '/signup', to: 'users#create'
end
