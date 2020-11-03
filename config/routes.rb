Rails.application.routes.draw do
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :users, only: [:index, :show], shallow: true do
    #Rename friendship index to something more understandable to humans
    get '/friends', to: 'friendships#index'
    resources :friendships, only: [:destroy, :index, :create, :new]
    resources :friendships, only: :update, param: :friend_request_id

    #View all posts a user has posted
    resources :posts, only: :index
  end

  #Routes for comments
  resources :posts, except: [:index, :new], shallow: true do
    resources :comments
  end
  
  #Routes for like model
  resources :posts, :comments do 
    resources :likes, only: :create
  end
  resources :likes, only: :destroy


  #Root for home page
  resources :home, only: :index

  root "home#index"
end
