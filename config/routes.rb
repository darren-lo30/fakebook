Rails.application.routes.draw do
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :posts
  resources :users, only: [:index, :show], shallow: true do
    member do 
      get 'friends'
    end
    resources :friendships, only: [:create]
  end

  root "posts#index"
end
