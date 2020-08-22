Rails.application.routes.draw do
  get :dynamic_select_category, to: 'products#dynamic_select_category'
  resources :products, shallow: true do
    resource :favorites, only: %i[create destroy]
    get :favorites, on: :collection
  end
  resources :products do
    resources :reviews
  end
  resources :cart_items
  devise_for :users, controllers: { omniauth_callbacks: 'users/omniauth_callbacks' }
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  
  root to: "home#index"
end
