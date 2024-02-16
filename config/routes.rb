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
    root to: "products#index", as: :admin_root
  end



  root "homes#index"

  get "garments" => "homes#garment"

  post "product/:product_id" => "line_items#add_to_cart"

end
