class ProductsController < ApplicationController

  def order_show
    @order = Order.find(params[:id])
  end

  def index
    @orders_pagy, @orders = pagy(current_user.orders)
  end


  def show
    @product = Product.find(params[:id])
  end

end