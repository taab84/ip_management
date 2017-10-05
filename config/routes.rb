Rails.application.routes.draw do
  get 'settings/change_locale'

  # gems generated routes
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  devise_for :users

  # custom routes
  root to: "home#index"
  get 'home/info'
  get 'home/help'

  # Cahnge locale routes
  get '/change_locale/:locale', to: 'settings#change_locale', as: :change_locale

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

end
