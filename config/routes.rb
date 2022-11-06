Rails.application.routes.draw do
  get 'product_categories/index'#, to: 'product_categories#index', as: 'product_categories'
  get 'product_categories/show' #, to: 'product_categories#show', as: 'product_category'
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  get 'contact', to: 'pages#contact', as: 'contact'

  get 'about', to: 'pages#about', as: 'about'

  get 'products/index'
  get 'products/show'

  get 'sale', to: 'products#sale', as: 'sale'
  get 'new', to: 'products#new', as: 'new'

  root to: 'products#index'

  resources :products, only: [:index, :show]
  resources :pages, only: [:about, :contact]
  resources :product_categories, only: [:index, :show]
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
