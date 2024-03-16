class ProductsController < ApplicationController

  def order_show
    @order = Order.find(params[:id])
  end

  def index
    @orders = current_user.orders
  end


  def show
    @product = Product.find(params[:id])
  end

end