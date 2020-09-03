Rails.application.routes.draw do
  
  root to: 'toppages#index'
  get 'toppages', to: 'toppages#index'
  
  get 'login', to: 'sessions#new'
  post 'login', to: 'sessions#create'
  delete 'logout', to: 'sessions#destroy'
  
  get 'signup', to: 'users#new'
  
  get 'edit_profile', to: 'users#edit_profile'
  get 'edit_user', to: 'users#edit_user'
  resources :users, only: [:index, :new, :create, :update] do
    member do
      get :followings
      get :followers
    end
    # collection do
    #   get :search
    # end
  end
  resources :books, only: [:new,:show, :create, :destroy, :edit, :update]
  
  resources :relationships, only: [:create, :destroy]
end