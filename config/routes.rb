Rails.application.routes.draw do
  resources :line_items, only: [:index, :create, :update, :destroy] 
  resources :carts, only: [:index]
  
  resources :orders, only: [:new, :index, :create, :show]
  post 'orders/confirm' => 'orders#confirm', as: 'order_confirm'
  get 'orders/thanks' => 'orders#thanks', as: 'order_thanks'
  resources :categories, only: [:index, :show]
  devise_for :admins
  namespace :admins do
    resources :products, only: [:index, :create, :new, :edit, :update, :destroy]
  end
  
  resources :products, shallow: true do
    resource :favorites, only: %i[create destroy]
    get :favorites, on: :collection
  end
  resources :products, only: [:index, :show] do
    resources :reviews
  end
  devise_for :users, controllers: { omniauth_callbacks: 'users/omniauth_callbacks' }
  
  root to: "home#index"
end
