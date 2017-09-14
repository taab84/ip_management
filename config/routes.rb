Rails.application.routes.draw do
  namespace :admin do
    resources :users
    # resources :administrators

    root to: "users#index"
  end

  devise_for :users
  root to: "home#index"
  #get 'home/index'

  get 'home/info'

  get 'home/help'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

end
