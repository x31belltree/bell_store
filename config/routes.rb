Rails.application.routes.draw do
  get 'favorites/create'
  get 'favorites/destroy'
  resources :products do
    resources :reviews
  end
  resources :products, shallow: true do
    resource :favorites, only: %i[create destroy]
    get :favorites, on: :collection
  end
  devise_for :users, controllers: { omniauth_callbacks: 'users/omniauth_callbacks' }
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  
  root to: "home#index"
end
