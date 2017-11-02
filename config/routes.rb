Rails.application.routes.draw do
  get 'settings/change_locale'

  # gems generated routes
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  devise_for :users
  # resources routes
  resources :receipts
  resources :mark_receipts, :controller => "receipts", :type => "MarkReceipt", :branch => "M"
  resources :identical_search_receipts, :controller => "receipts", :type => "IdenticalSearchReceipt", :branch => "M"
  resources :similar_search_receipts, :controller => "receipts", :type => "SimilarSearchReceipt", :branch => "M"
  resources :payement_orders, :controller => "orders", only: [:new, :create, :show]
  resources :md_orders, :controller => "orders", only: [:new, :create, :show]
  resources :pd_orders, :controller => "orders", only: [:new, :create, :show]


  # custom routes
  root to: "home#index"
  get 'home/info'
  get 'home/help'
  post 'orders/select_request'
  # post 'orders/create'
  # get 'orders/new'
  # get 'receipts/old', to: 'receipts#old'

  # Cahnge locale routes
  get '/change_locale/:locale', to: 'settings#change_locale', as: :change_locale

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

end
