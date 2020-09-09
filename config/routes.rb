Rails.application.routes.draw do
  get 'orders/confirm'
  get 'orders/index'
  get 'orders/new'
  get 'orders/show'
  get 'orders/thanks'
  get 'order_items/index'
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
  resources :cart_items, only: [:index, :create, :update, :destroy] do
    collection do
        delete 'destroy_all'
    end
  end
  resources :orders, only: [:new, :index, :create, :show]
  post 'orders/confirm' => 'orders#confirm', as: 'order_confirm'
  get 'orders/thanks' => 'orders#thanks', as: 'order_thanks'
  devise_for :users, controllers: { omniauth_callbacks: 'users/omniauth_callbacks' }
  
  root to: "home#index"
end
