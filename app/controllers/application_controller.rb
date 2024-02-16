class ApplicationController < ActionController::Base

  before_action :set_current_cart

  def set_current_cart
    if current_user && current_user.cart.nil?
      cart = Cart.create
      cart.update!(user: current_user)
    elsif current_user && current_user.cart.present?
      cart = Cart.where(user_id: current_user.id).last
    elsif !current_user
      if session[:cart_id].nil?
        cart = Cart.create
      else
        cart = Cart.find_by(id: session[:cart_id])
      end
    end
    session[:cart_id] = cart.id
    @current_cart = cart
  end

end
