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
  post '/receipts/tax_evaluation' , to: 'receipts#tax_evaluation'

  # resources routes
  # for receipts
  resources :receipts
  # resources :mark_receipts, as: "receipts", :controller => "receipts", :type => "MarkReceipt", :branch => "M",
  # resources :identical_search_receipts, :controller => "receipts", :type => "IdenticalSearchReceipt", :branch => "M", :path => 'receipts'
  # resources :similar_search_receipts, :controller => "receipts", :type => "SimilarSearchReceipt", :branch => "M", :path => 'receipts'
  # resources :rectification_mark_receipts, :controller => "receipts", :type => "RectificationMarkReceipt", :branch => "M", :path => 'receipts'
  # for orders
  resources :orders, :controller => "orders", only: [:new, :create, :show, :index]
  resources :md_orders, :controller => "orders", only: [:new, :show, :index]
  resources :pd_orders, :controller => "orders", only: [:new, :show, :index]
  resources :md_orders, :controller => "orders", only: [:create,], :formats=>[:json]
  resources :pd_orders, :controller => "orders", only: [:create], :formats=>[:json]

  # Cahnge locale routes
  get '/change_locale/:locale', to: 'settings#change_locale', as: :change_locale

end
