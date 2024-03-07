class CategoriesController < ApplicationController

  def show
    @category = Category.find(params[:id])
    if params[:query] == "Price Low To High" 
      @products = @category.products.order(price: :asc)
    elsif params[:query] == "Price High To Low"
      @products = @category.products.order(price: :desc)
    else
      @products = @category.products
    end
  end

  
end