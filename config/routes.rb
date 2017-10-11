Rails.application.routes.draw do
  get 'settings/change_locale'

  # gems generated routes
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  devise_for :users
  # resources routes
  resources :receipts
  resources :mark_receipts, :controller => "receipts", :type => "MarkReceipt"
  resources :identical_search_receipts, :controller => "receipts", :type => "IdenticalSearchReceipt"
  resources :similar_search_receipts, :controller => "receipts", :type => "SimilarSearchReceipt"

  # custom routes
  root to: "home#index"
  get 'home/info'
  get 'home/help'

  # Cahnge locale routes
  get '/change_locale/:locale', to: 'settings#change_locale', as: :change_locale

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

end
