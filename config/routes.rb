Rails.application.routes.draw do
  # get 'order/show'
  get 'order/checkout', to: 'checkouts#show'
  get 'checkout/success', to: 'checkouts#success'

  get 'order', to: 'order#show', as: 'order'
  post 'order/add'
  post 'order/remove'

  post 'products/add_to_cart/:id', to: 'products#add_to_cart', as: 'add_to_cart'
  delete 'products/remove_from_cart/:id', to: 'products#remove_from_cart', as: 'remove_from_cart'

  devise_for :customers, controllers: {
    sessions: 'customers/sessions',
    registrations: 'customers/registrations'
  }
  get 'search/index'
  get 'product_categories/index'#, to: 'product_categories#index', as: 'product_categories'
  get 'product_categories/show' #, to: 'product_categories#show', as: 'product_category'
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  get 'contact', to: 'pages#contact', as: 'contact'

  get 'about', to: 'pages#about', as: 'about'

  get 'search', to: 'search#index', as: 'search'

  get 'ankara', to: 'product_categories#ankara', as: 'ankara'
  get 'adire', to: 'product_categories#adire', as: 'adire'
  get 'asooke', to: 'product_categories#asooke', as: 'asooke'
  get 'lace', to: 'product_categories#lace', as: 'lace'

  get 'products/index'
  get 'products/show'

  get 'sale', to: 'products#sale', as: 'sale'
  get 'new', to: 'products#new', as: 'new'

  root to: 'products#index'

  resources :products, only: [:index, :show]
  resources :pages, only: [:about, :contact]
  resources :product_categories, only: [:index, :show]
  resources :after_signup
  #resources :checkout, only: [:create]
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
