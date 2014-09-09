Rails.application.routes.draw do

    # Set the root path
    root 'welcome#index'

    resources :categories, only: [:show, :create, :new, :edit, :update]
    
    resources :competitions do
        resources :entries, only: [:new, :create, :destroy] do
            post 'vote', on: :member
        end
        collection do
            get 'hot'
            get 'popular'
        end
    end

    resources :robots do
        resources :comments, only: [:create, :destroy]
        collection do
            get 'hot'
            get 'popular'
        end
    end

    resources :users do
        member do
            get 'robots'
            get 'competitions'
        end
    end

    get 'tiers/:name', to: 'tiers#show', as: :tier
    
    # Routes for user/session handling
    resources :sessions, only: [:new, :create, :destroy]
    match '/signup', to: 'users#new', via: 'get'
    match '/signin', to: 'sessions#new', via: 'get'
    match '/signout', to: 'sessions#destroy', via: 'delete'
end
