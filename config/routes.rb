Rails.application.routes.draw do
  namespace :admins do
    get 'products/edit'
    get 'products/index'
    get 'products/new'
    get 'products/show'
  end
  devise_for :admins
  namespace :admins do
    get 'homes/top' => 'homes#top', as:'top'
    resources :products, only: [:index, :create, :new, :edit, :show, :update]
  end
  
  get :dynamic_select_category, to: 'products#dynamic_select_category'
  resources :products, shallow: true do
    resource :favorites, only: %i[create destroy]
    get :favorites, on: :collection
  end
  resources :products do
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
