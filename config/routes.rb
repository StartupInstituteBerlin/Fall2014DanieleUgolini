Rails.application.routes.draw do
 
  devise_for :owners
  resources :restaurants
  root 'restaurants#index'

end
