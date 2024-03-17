class CategoriesController < ApplicationController

  def show
    @category = Category.find(params[:id])
    if params[:query] == "Price Low To High" 
      @products_pagy, @products = pagy(@category.products.order(price: :asc))
    elsif params[:query] == "Price High To Low"
      @products_pagy, @products = pagy(@category.products.order(price: :desc))
    else
      @products_pagy, @products = pagy(@category.products)
    end
  end
  
end