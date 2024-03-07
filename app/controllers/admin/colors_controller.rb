class Admin::ColorsController < ApplicationController
  before_action :set_color, only: %i[ edit update destroy ]
  before_action :set_product
  before_action :authenticate_admin!


  def index
    @colors = @product.colors
  end

  def new
    @color = @product.colors.new
  end

  def edit
  end

  def create
    @color = @product.colors.new(color_params)

    respond_to do |format|
      if @color.save
        format.html { redirect_to admin_product_colors_path(@product), notice: "Color was successfully created." }
      else
        format.html { render :new, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @color.update(color_params)
        format.html { redirect_to admin_product_colors_path(@product), notice: "Color was successfully updated." }
      else
        format.html { render :edit, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @color.destroy

    respond_to do |format|
      format.html { redirect_to admin_product_colors_path(@product), notice: "Color was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    def set_product
      @product = Product.find(params[:product_id])
    end

    def set_color
      @color = Color.find(params[:id])
    end

    def color_params
      params.require(:color).permit(:name, :product_id)
    end
end
