Rails.application.routes.draw do
  devise_for :users, controllers: {omniauth_callbacks: 'users/omniauth_callbacks'}

  #Likeable concern
  concern :likeable do 
    resources :likes, only: :create
  end

  #Commentable concern
  concern :commentable do
    resources :comments, only: :create
  end


  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :users, only: [:index, :show], shallow: true do
    #Rename friendship index to something more understandable to humans
    get '/friends', to: 'friendships#index'
    resources :friendships, only: [:destroy, :index, :create, :new]
    resources :friendships, only: :update, param: :friend_request_id

  end

  #Routes for comments
  resources :posts, except: :new do
    concerns :commentable
    concerns :likeable
  end
  
  #Makes comments likeable
  resources :comments, only: [] do 
    concerns :likeable
  end

  
  resources :likes, only: :destroy
  resources :comments, only: :destroy

  get '/:page', to: 'pages#show', as: 'page'
  root "posts#index"
end
