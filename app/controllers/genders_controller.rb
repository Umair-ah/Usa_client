class GendersController < ApplicationController
  def show
    @gender = Gender.find(params[:id])
  end
end