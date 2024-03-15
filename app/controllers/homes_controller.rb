class HomesController < ApplicationController

  def index
    @recent_products = Product.order(created_at: :desc).limit(2)
    @category = Category.last
    @categories = Category.all
    @latest_category_clothes = @category.products
  end

  def categories
    @categories = Category.all
  end

  def track
    order_id = params[:order_id]
    email = params[:email]

    order_id_regex = /\A\d+\z/ # Only numbers
    email_regex = /\A[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Z|a-z]{2,}\z/ # Email format

    if params[:order_id].present? && params[:email].present?
      if order_id.match?(order_id_regex) && email.match?(email_regex)
        @order = Order.find_by(id: order_id, email: email)
        if @order
          render :track
        else
          render :not_found
        end
      end
    end

    
  end

end