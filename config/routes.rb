Rails.application.routes.draw do
  # gems generated routes
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  devise_for :users
  # custom routes
  root to: "home#index"
  get 'home/info'
  get 'home/help'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

end
