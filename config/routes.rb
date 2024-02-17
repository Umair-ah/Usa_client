Rails.application.routes.draw do
  
  devise_for :admins, skip: [:registrations]
  devise_for :users, controllers: {
    registrations: 'users/registrations'
  }
  

  namespace :admin do
    resources :categories
    resources :products do
      resources :stocks
    end
  end

  authenticated :admin do
    root to: "admin/categories#index", as: :admin_root
  end





  root "homes#index"
  get "cart/:cart_id", to: "carts#show", as: :cart

  resources :products

  post "size/:product_id" => "line_items#size", as: "size_select"


  post "product/:product_id/:stock_id" => "line_items#add_to_cart", as: "add_to_cart"

  post "add/:product_id/:stock_id" => "line_items#add_quantity", as: :add_quantity
  post "subtract/:product_id/:stock_id" => "line_items#subtract_quantity", as: :subtract_quantity
  post "remove/:product_id/:stock_id" => "line_items#destroy_from_cart", as: :destroy_from_cart



end
