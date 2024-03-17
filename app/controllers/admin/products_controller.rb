class Admin::ProductsController < ApplicationController
  before_action :set_product, only: %i[ edit update destroy ]
  before_action :authenticate_admin!


  def show
    @order = Order.find(params[:order_id])
  end


  def order_cancelled
    @order = Order.find(params[:order_id])
    @order.cancelled!
    respond_to do |format|
      format.turbo_stream {
        render turbo_stream:
        turbo_stream.update(
          "order_#{@order.id}_status",
          partial:"admin/products/status",
          locals: { order: @order }
        )
      }

    end
  end
  
  def order_completed
    @order = Order.find(params[:order_id])
    @order.completed!
    respond_to do |format|
      format.turbo_stream {
        render turbo_stream:
        turbo_stream.update(
          "order_#{@order.id}_status",
          partial:"admin/products/status",
          locals: { order: @order }
        )
      }
    end
  end

  def order_out_for_delivery
    @order = Order.find(params[:order_id])
    @order.out_for_delivery!
    respond_to do |format|
      format.turbo_stream {
        render turbo_stream:
        turbo_stream.update(
          "order_#{@order.id}_status",
          partial:"admin/products/status",
          locals: { order: @order }
        )
      }
    end
  end

  def order_pending
    @order = Order.find(params[:order_id])
    @order.pending!
    respond_to do |format|
      format.turbo_stream {
        render turbo_stream:
        turbo_stream.update(
          "order_#{@order.id}_status",
          partial:"admin/products/status",
          locals: { order: @order }
        )
      }
    end
  end


  def orders
    if params[:query_two].present?
      @orders_pagy, @orders = pagy(Order.where(id: params[:query_two]))
    elsif params[:query].present?
      @orders_pagy, @orders = pagy(Order.where("name ILIKE ? OR email ILIKE ? OR phone_number ILIKE ?", "%#{params[:query]}%", "%#{params[:query]}%", "%#{params[:query]}%"))
    elsif params[:status] == 'pending'
      @orders_pagy, @orders = pagy(Order.where(status: 'pending'))
    elsif params[:status] == 'out for delivery'
      @orders_pagy, @orders = pagy(Order.where(status: 'out for delivery'))
    elsif params[:status] == 'completed'
      @orders_pagy, @orders = pagy(Order.where(status: 'completed'))
    elsif params[:status] == 'cancelled'
      @orders_pagy, @orders = pagy(Order.where(status: 'cancelled'))
    else
      @orders_pagy, @orders = pagy(Order.all.order(created_at: :desc))
    end
  end
  
  def remove_image
    product = Product.find(params[:product_id])
    image = product.images.find(params[:image_blob_id])
    image.purge
    redirect_to edit_admin_product_path(product)
  end

  def index
    if params[:product_name].present? && params[:category] == ""
      @products = Product.where("name ILIKE ?", "%#{params[:product_name]}%")
    elsif params[:product_name].present? && params[:category].present?
      @products = Product.where("name ILIKE ? AND category_id = ?", "%#{params[:product_name]}%", params[:category].to_i)
    elsif params[:product_name] == "" && params[:category].present?
      @products = Product.where("category_id = ?", params[:category].to_i)
    else
      @products = Product.all
    end
  end

  

  def new
    @product = Product.new
  end

  def edit
  end

  def create
    @product = Product.new(product_params)

    respond_to do |format|
      if @product.save
        format.html { redirect_to admin_products_url notice: "Product was successfully created." }
      else
        format.html { render :new, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @product.update(product_params)
        format.html { redirect_to admin_products_url, notice: "Product was successfully updated." }
      else
        format.html { render :edit, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @product.destroy
    respond_to do |format|
      format.html { redirect_to admin_products_url, notice: "Product was successfully destroyed." }
    end
  end

  private
    def set_product
      @product = Product.find(params[:id])
    end

    def product_params
      params.require(:product).permit(:category_id, :name, :description, :price, images: [])
    end
end
