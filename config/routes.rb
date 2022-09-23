Rails.application.routes.draw do
  root to: 'home#index'
  resources :warehouses, only: [:index, :show, :new, :create, :edit, :update, :destroy]
end