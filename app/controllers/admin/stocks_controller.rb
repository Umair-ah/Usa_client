class Admin::StocksController < ApplicationController
  before_action :set_stock, only: %i[ show edit update destroy ]
  before_action :set_product
  before_action :set_color


  before_action :authenticate_admin!

  def index
    @stocks = @color.stocks
  end

  def show
  end

  def new
    @stock = Stock.new
  end

  def edit
  end

  def create
    @stock = @color.stocks.new(stock_params)

    respond_to do |format|
      if @stock.save
        format.html { redirect_to admin_product_color_stocks_url(@product, @color), notice: "Stock was successfully created." }
      else
        format.html { render :new, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @stock.update(stock_params)
        format.html { redirect_to admin_product_color_stocks_url(@product, @color), notice: "Stock was successfully updated." }
      else
        format.html { render :edit, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @stock.destroy

    respond_to do |format|
      format.html { redirect_to admin_product_color_stocks_url(@product, @color), notice: "Stock was successfully destroyed." }
    end
  end

  private
    def set_color
      @color = Color.find(params[:color_id])
    end
   
    def set_product
      @product = Product.find(params[:product_id])
    end

    def set_stock
      @stock = Stock.find(params[:id])
    end

    def stock_params
      params.require(:stock).permit(:product_id, :color_id, :size, :piece)
    end
end
