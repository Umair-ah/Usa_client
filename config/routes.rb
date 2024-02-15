Rails.application.routes.draw do
  
  devise_for :admins, skip: [:registrations]
  devise_for :users
  
  resources :categories
  resources :products
  resources :stocks



  root "homes#index"

end
