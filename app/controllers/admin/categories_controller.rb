class Admin::CategoriesController < ApplicationController
  before_action :set_category, only: %i[ edit update destroy ]
  before_action :authenticate_admin!

  def remove_thumbnail
    category = Category.find(params[:category_id])
    thumbnail = category.thumbnail
    thumbnail.purge
    redirect_to edit_admin_category_path(category)
  end

  def index
    @categories_pagy, @categories = pagy(Category.all)
  end

  def new
    @category = Category.new
  end

  def edit
  end

  def create
    @category = Category.new(category_params)

    respond_to do |format|
      if @category.save
        format.html { redirect_to admin_root_path, notice: "Category was successfully created." }
      else
        format.html { render :new, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @category.update(category_params)
        format.html { redirect_to admin_root_path, notice: "Category was successfully updated." }
      else
        format.html { render :edit, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @category.destroy

    respond_to do |format|
      format.html { redirect_to admin_root_path, notice: "Category was successfully destroyed." }
    end
  end

  private
    def set_category
      @category = Category.find(params[:id])
    end

    def category_params
      params.require(:category).permit(:name, :thumbnail, :gender_id)
    end
end
