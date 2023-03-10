Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root to: 'toppages#index'
  
  get 'signup', to: 'users#new'
  resources :users, only: [:index, :show, :create]
  
  get 'login', to: 'sessions#new'
  post 'login', to: 'sessions#create'
  delete 'logout', to: 'sessions#destroy'
  
  resources :tasks 
  resources :shops
  resources :favorites, only: [:create, :destroy]
  
  resources :shops do
    member do
      get :items
    end
  end  
  
  resources :toppages do
    collection do
      get :likes
    end
  end
  

  
end
 