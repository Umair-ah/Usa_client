Rails.application.routes.draw do

  devise_for :admins, skip: [:registrations]
  devise_for :users
  resources :categories




  root "homes#index"

end
