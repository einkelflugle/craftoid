Rails.application.routes.draw do

    # Set the root path
    root 'welcome#index'

    resources :categories, only: [:show, :create, :new, :edit, :update]

    resources :robots, :users do
      resources :comments, only: [:create, :destroy]
    end

    get 'tiers/:name', to: 'tiers#show', as: :tier

    # Show a robots by user
    get 'users/:id/robots', to: 'users#robots', as: :user_robots

    # Show robots by most commented
    get '/hot', to: 'robots#hot', as: :hot_robots

    # Show robots by most viewed
    get '/popular', to: 'robots#popular', as: :popular_robots

    # Routes for user/session handling
    resources :sessions, only: [:new, :create, :destroy]
    match '/signup', to: 'users#new', via: 'get'
    match '/signin', to: 'sessions#new', via: 'get'
    match '/signout', to: 'sessions#destroy', via: 'delete'
end
