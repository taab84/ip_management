Rails.application.routes.draw do
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  devise_for :users
  root to: "home#index"
  #get 'home/index'

  get 'home/info'

  get 'home/help'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

end
