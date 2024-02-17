class Admin::StocksController < ApplicationController
  before_action :set_stock, only: %i[ show edit update destroy ]
  before_action :set_product

  before_action :authenticate_admin!

  def index
    @stocks = Stock.all
  end

  def show
  end

  def new
    @stock = Stock.new
  end

  def edit
  end

  def create
    @stock = @product.stocks.new(stock_params)

    respond_to do |format|
      if @stock.save
        format.html { redirect_to admin_product_stocks_url(@product), notice: "Stock was successfully created." }
      else
        format.html { render :new, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @stock.update(stock_params)
        format.html { redirect_to admin_product_stocks_url(@stock), notice: "Stock was successfully updated." }
      else
        format.html { render :edit, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @stock.destroy

    respond_to do |format|
      format.html { redirect_to admin_stocks_url, notice: "Stock was successfully destroyed." }
    end
  end

  private
    def set_product
      @product = Product.find(params[:product_id])
    end

    def set_stock
      @stock = Stock.find(params[:id])
    end

    def stock_params
      params.require(:stock).permit(:product_id, :size, :piece)
    end
end
