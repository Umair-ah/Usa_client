class LineItemsController < ApplicationController

  def size
    @product = Product.find(params[:product_id])
    @stock_of_selected_product = @product.stocks.find(params[:stock_id])
    if @stock_of_selected_product.available?
      respond_to do |format|
        format.turbo_stream { 
          render turbo_stream: 
          turbo_stream.update(
            "add_to_cart_btn",
            partial: "products/add_to_cart",
            locals: {stock: @stock_of_selected_product }
          )
        }
      end
    else
      respond_to do |format|
        format.turbo_stream{
          render turbo_stream: 
          turbo_stream.update(
            "add_to_cart_btn",
            partial: "products/out_of_stock"
          )
        }

      end
    end
  end

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