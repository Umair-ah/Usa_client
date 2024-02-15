class HomesController < ApplicationController

  def garment
    @products = Product.all
  end

  def index
    
  end
end