Rails.application.routes.draw do
  
  devise_for :admins, skip: [:registrations]
  devise_for :users
  

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

  get "products" => "products#index"

  post "product/:product_id" => "line_items#add_to_cart", as: "add_to_cart"

end
