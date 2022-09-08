Rails.application.routes.draw do
  devise_for :users
  root to: "pages#home"
  resources :pets do
    resources :applications, only: [:new, :create, :edit, :update]
    resources :favourites, only: [:create]
  end
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  resources :applications, only: [:show, :destroy, :index] do
    resources :messages
  end
  resources :favourites, only: [:index, :destroy]
  # Defines the root path route ("/")
  # root "articles#index"
  resources :users, only: [:show, :destroy, :edit, :update]
end
