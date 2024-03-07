class LineItemsController < ApplicationController


  def destroy_from_cart
    @product = Product.find(params[:product_id])
    @stock_of_selected_product = @product.stocks.find(params[:stock_id])
    @line_item = @current_cart.line_items.find_by(product_id: @product, stock_id: @stock_of_selected_product)
    @line_item.destroy
    flash[:alert] = "Removed #{@product.name}"
    respond_to do |format|
      format.turbo_stream{
        render turbo_stream:
        turbo_stream.update(
          "cart",
          partial:"carts/cart",
        )
      }
    end
  end

  def add_quantity
    @product = Product.find(params[:product_id])
    @stock_of_selected_product = @product.stocks.find(params[:stock_id])
    @line_item = @current_cart.line_items.find_by(product_id: @product, stock_id: @stock_of_selected_product)

    if @stock_of_selected_product.available?
      if @line_item.quantity < @stock_of_selected_product.piece
        @line_item.quantity += 1
        @line_item.save
      end
    else
      @line_item.destroy
      flash[:alert] = "Out Of Stock"
    end
    respond_to do |format|
      format.turbo_stream{
        render turbo_stream:
        turbo_stream.update(
          "cart",
          partial:"carts/cart",
        )
      }
    end
  end


  def subtract_quantity
    @product = Product.find(params[:product_id])
    @stock_of_selected_product = @product.stocks.find(params[:stock_id])
    @line_item = @current_cart.line_items.find_by(product_id: @product, stock_id: @stock_of_selected_product)
    if @stock_of_selected_product.available?
      @line_item.quantity -= 1
      if @line_item.quantity == 0
        @line_item.destroy
      end
      @line_item.save
    else
      @line_item.destroy
      flash[:alert] = "Out Of Stock"
    end
    redirect_to cart_path(@current_cart)
  end

  def color
    @product = Product.find(params[:product_id])
    @color_of_selected_product = @product.colors.find(params[:color_id])
    respond_to do |format|
      format.turbo_stream {
        render turbo_stream:
        [

          turbo_stream.update(
            'sizes',
            partial: "products/sizes"
          ),
          turbo_stream.update(
            "add_to_cart_btn",
            partial: "products/empty",
          )

        ]
      }
    end
  end

  def size
    @product = Product.find(params[:product_id])
    @color = Color.find(params[:color_id])
    @stock_of_selected_product = @color.stocks.find(params[:stock_id])
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
    @product = Product.find(params[:product_id])
    @color = @product.colors.find(params[:color_id])
    @stock = @color.stocks.find(params[:stock_id])
  
    @line_item = @current_cart.line_items.find_by(product_id: @product, stock_id: @stock)
  
    if @line_item
      flash.now[:notice] = "Item is already in cart"
    else
      if @stock.available?
        puts "Reached stock is available"
        @line_item = LineItem.new
        @line_item.cart = @current_cart
        @line_item.product = @product
        @line_item.color = @color
        @line_item.stock = @stock
        @line_item.save
        flash.now[:notice] = "Item added to cart"
      end
    end
  
    redirect_to cart_path(@current_cart)
  end
  

  
end