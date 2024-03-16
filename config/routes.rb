Rails.application.routes.draw do
  
  devise_for :admins, skip: [:registrations]
  devise_for :users, controllers: {
    registrations: 'users/registrations'
  }
  
  
  namespace :admin do
    get "/orders", to: "products#orders"
    get "/order/:order_id", to: "products#show", as: :product_show
    post "/order_pending/:order_id", to: "products#order_pending", as: :pending
    post "/order_out_for_delivery/:order_id", to: "products#order_out_for_delivery", as: :out_for_delivery
    post "/order_completed/:order_id", to: "products#order_completed", as: :completed
    post "/order_cancelled/:order_id", to: "products#order_cancelled", as: :cancelled


    resources :genders, except: [:show ]
    resources :categories, except: [:show ]
    resources :products, except: [:show ] do
      resources :colors, except: [:show ] do
        resources :stocks
      end
    end
  end

  authenticated :admin do
    root to: "admin/categories#index", as: :admin_root
  end





  root "homes#index"
  get "cart/:cart_id", to: "carts#show", as: :cart

  resources :products
  resources :categories, only: [:show]


  post "color/:product_id" => "line_items#color", as: "color_select"

  post "size/:product_id/:color_id" => "line_items#size", as: "size_select"



  post "product/:product_id/:color_id/:stock_id" => "line_items#add_to_cart", as: "add_to_cart"

  post "add/:product_id/:stock_id" => "line_items#add_quantity", as: :add_quantity
  post "subtract/:product_id/:stock_id" => "line_items#subtract_quantity", as: :subtract_quantity
  post "remove/:product_id/:stock_id" => "line_items#destroy_from_cart", as: :destroy_from_cart


  post "/checkout", to: "payments#checkout", as: :checkout
  post "/checkout_form", to: "payments#checkout_form", as: :checkout_form
  post "get_pin", to: "payments#get_pin", as: :get_pin

  post "/select_payment_option", to: "payments#select_payment_option", as: :select_payment_option
  get "/success", to: "payments#success", as: :success

  get "orders", to: "payments#index", as: :orders

  get "categories", to: "homes#categories", as: :categories

  get "track", to: "homes#track", as: :track

  post "remove_image/:product_id/:image_blob_id", to: "admin/products#remove_image", as: :remove_image
  post "remove_thumbnail/:category_id/:thumbnail_blob_id", to: "admin/categories#remove_thumbnail", as: :remove_thumbnail






end
