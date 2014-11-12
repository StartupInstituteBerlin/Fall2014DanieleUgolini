Rails.application.routes.draw do

  devise_for :user

  get '/dashboard' => 'users#dashboard', :as => :dashboard

  resources :restaurants do
  	resources :reservations, :only => [:new, :create]
  end

  resources :reservations, :except => [:new, :create]

  root :to => 'restaurants#index'

end
