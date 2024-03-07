Rails.application.routes.draw do
  
  devise_for :admins, skip: [:registrations]
  devise_for :users, controllers: {
    registrations: 'users/registrations'
  }
  
  
  namespace :admin do
    resources :genders, except: [:show ]
    resources :categories, except: [:show ]
    resources :products, except: [:show ] do
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


  get "/checkout", to: "payments#checkout", as: :checkout
  post "/checkout_form", to: "payments#checkout_form", as: :checkout_form
  post "get_pin", to: "payments#get_pin", as: :get_pin

  post "/select_payment_option", to: "payments#select_payment_option", as: :select_payment_option
  post "/order", to: "payments#order", as: :order

  get "orders", to: "payments#index", as: :orders

  get "categories", to: "homes#categories", as: :categories





end
