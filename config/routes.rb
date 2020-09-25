Rails.application.routes.draw do
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :posts
  resources :users, only: [:index, :show], shallow: true do
    #Rename friendship index to something more understandable to humans
    get '/friends', to: 'friendships#index'
    resources :friendships, only: [:destroy, :index, :create, :new]
    resources :friendships, only: [:update], param: :friend_request_id
  end

  root "posts#index"
end
