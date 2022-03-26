Rails.application.routes.draw do
  get 'profiles/new'
  root 'top_pages#home'
  devise_for :users, controllers: {registrations: 'users/registrations',sessions: 'users/sessions',}
  resources :users
  resources :rooms
  resources :reservations
  resources :profiles
  get 'search' => 'rooms#search'
  get 'area' => 'rooms#area'
end
