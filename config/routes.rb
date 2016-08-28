Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  devise_for :users
  resources :venues, only: [:index, :show] do
    member do
      post :upvote
    end
  end
  resources :accounts, only: [:index, :new, :create, :destroy]
  resources :results, only: [:index, :create]
  resources :bookings, only: [:new, :create, :destroy]
end
