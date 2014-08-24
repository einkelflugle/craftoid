Rails.application.routes.draw do

    # Set the root path to the main list of robots
    root 'robots#index'

    resources :categories

    resources :robots, :users do
      resources :comments, only: [:create, :destroy]
    end

    get 'tiers/:name', to: 'tiers#show', as: :tier

    # Show a user's robots
    get 'users/:id/robots', to: 'users#robots', as: :user_robots

    # Routes for user/session handling
    resources :sessions, only: [:new, :create, :destroy]
    match '/signup', to: 'users#new', via: 'get'
    match '/signin', to: 'sessions#new', via: 'get'
    match '/signout', to: 'sessions#destroy', via: 'delete'
end
