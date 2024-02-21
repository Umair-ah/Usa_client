class HomesController < ApplicationController

  def index
    @recent_products = Product.order(created_at: :desc).limit(2)
    @category = Category.last
    @latest_category_clothes = @category.products
    
  end
end