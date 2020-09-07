Rails.application.routes.draw do
  resources :categories, only: [:index, :show]
  devise_for :admins
  namespace :admins do
    resources :products, only: [:index, :create, :new, :edit, :update, :destroy]
  end
  get :dynamic_select_category, to: 'admins/products#dynamic_select_category'
  
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
  devise_for :users, controllers: { omniauth_callbacks: 'users/omniauth_callbacks' }
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  
  root to: "home#index"
end
