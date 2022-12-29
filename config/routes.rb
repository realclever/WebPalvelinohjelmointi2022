Rails.application.routes.draw do
  resources :memberships
  resources :beer_clubs
  resources :users do
    post 'toggle_mode', on: :member
  end
  resources :beers
  resources :breweries do
    post 'toggle_activity', on: :member
  end
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  root 'breweries#index'
  get 'kaikki_bisset', to: 'beers#index'
  get 'signup', to: 'users#new'
  get 'signin', to: 'sessions#new'
  resources :places, only: [:index, :show]
  resources :styles
  post 'places', to: 'places#search'
  delete 'signout', to: 'sessions#destroy'
  resources :ratings, only: %i[index new create destroy]
  resource :session, only: [:new, :create, :destroy]
  
end
