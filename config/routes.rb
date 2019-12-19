Rails.application.routes.draw do
  root 'sessions#home'

  resources :budgets, only: [:index, :create, :new]
  resources :accounts, only: [:index, :create, :new]
  resources :transactions, only: [:index, :create, :new]

  resources :users, only: [:show, :create, :edit] do
    resources :budgets, shallow: true
    resources :accounts, shallow: true
  end
  resources :accounts, shallow: true do
    resources :transactions, shallow: true
  end

  get '/signin' => "sessions#new"
  post '/signin' => "sessions#create"
  get '/signout' => "sessions#destroy"
  get '/signup' => "users#new", as: 'signup'
  post '/signup' => "users#show"
  match '/auth/:provider/callback', to: 'sessions#create', via: [:get, :post]
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
