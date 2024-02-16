class LineItemsController < ApplicationController

  def add_to_cart
    @selected_product = Product.find(params[:product_id])
    if @current_cart.products.include?(@selected_product)
      @line_item = @current_cart.line_items.find_by(product_id: @selected_product)
      flash.now[:notice] = "Item is already in cart"
    else
      @line_item = LineItem.new
      @line_item.cart = @current_cart
      @line_item.product = @selected_product
      @line_item.save
      flash.now[:notice] = "Item added to cart"
    end
    redirect_to cart_path(@current_cart)
  end

  
end