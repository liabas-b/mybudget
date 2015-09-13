Rails.application.routes.draw do

  resources :accounts, only: [:show, :update] do
    member do
      post :sold_at
    end
  end
  resources :operations, only: [:create, :destroy]

  root to: 'welcome#index'
end
