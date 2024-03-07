class Admin::GendersController < ApplicationController
  before_action :set_gender, only: %i[ edit update destroy ]
  before_action :authenticate_admin!


  def index
    @genders = Gender.all
  end

 

  def new
    @gender = Gender.new
  end

  def edit
  end

  def create
    @gender = Gender.new(gender_params)

    respond_to do |format|
      if @gender.save
        format.html { redirect_to admin_genders_url, notice: "Gender was successfully created." }
      else
        format.html { render :new, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @gender.update(gender_params)
        format.html { redirect_to admin_genders_url, notice: "Gender was successfully updated." }
      else
        format.html { render :edit, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @gender.destroy

    respond_to do |format|
      format.html { redirect_to admin_genders_url, notice: "Gender was successfully destroyed." }
    end
  end

  private
    def set_gender
      @gender = Gender.find(params[:id])
    end

    def gender_params
      params.require(:gender).permit(:name)
    end
end
