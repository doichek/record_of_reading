Rails.application.routes.draw do
  
  root to: 'sessions#new'  
  get 'login', to: 'sessions#new'
  post 'login', to: 'sessions#create'
  post 'login_guest', to: 'sessions#create_guest'
  delete 'logout', to: 'sessions#destroy'


  get 'signup', to: 'users#new'
  
  get 'edit_profile', to: 'users#edit_profile'
  get 'edit_account', to: 'users#edit_account'
  resources :users, only: [:index, :new, :create, :update]do
    member do
      get :followings
      get :followers
    end
  end
  
  resources :books, only: [:index, :new, :show, :create, :destroy, :edit, :update]
  
  resources :relationships, only: [:create, :destroy]
end