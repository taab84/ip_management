Rails.application.routes.draw do
  get 'settings/change_locale'

  # gems generated routes
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  devise_for :users

  # custom routes
  root to: "home#index"
  get 'home/info'
  get 'home/help'
  post '/orders/load' , to: 'orders#load'

  # resources routes
  resources :receipts, :controller => "receipts", :type => "Receipt"
  resources :mark_receipts, :controller => "receipts", :type => "MarkReceipt", :branch => "M"
  resources :identical_search_receipts, :controller => "receipts", :type => "IdenticalSearchReceipt", :branch => "M"
  resources :similar_search_receipts, :controller => "receipts", :type => "SimilarSearchReceipt", :branch => "M"
  resources :orders, :controller => "orders", only: [:new, :create, :show]
  resources :md_orders, :controller => "orders", only: [:new, :show]
  resources :pd_orders, :controller => "orders", only: [:new, :show]
  resources :md_orders, :controller => "orders", only: [:create,], :formats=>[:json]
  resources :pd_orders, :controller => "orders", only: [:create], :formats=>[:json]

  # Cahnge locale routes
  get '/change_locale/:locale', to: 'settings#change_locale', as: :change_locale

end
