Rails.application.routes.draw do

    # Set the root path
    root 'welcome#index'

    resources :categories, only: [:show, :create, :new, :edit, :update]

    resources :help_topics
    get '/help', to: 'help_topics#index'

    
    resources :competitions do
        post 'close', on: :member
        resources :entries, only: [:index, :new, :create, :destroy] do
            post 'vote', on: :member
            collection do
                get 'popular'
            end
        end
        collection do
            get 'hot'
            get 'popular'
        end
    end

    resources :robots do
        resources :comments, only: [:create, :destroy]
        post 'favorite', on: :member
        collection do
            get 'hot'
            get 'popular'
            get 'favorited'
        end
    end

    resources :users do
        member do
            get 'robots'
            get 'competitions'
            get 'favorites'
        end
    end

    get 'tiers/:name', to: 'tiers#show', as: :tier
    
    # Routes for user/session handling
    resources :sessions, only: [:new, :create, :destroy]
    match '/signup', to: 'users#new', via: 'get'
    match '/signin', to: 'sessions#new', via: 'get'
    match '/signout', to: 'sessions#destroy', via: 'delete'
end
