class DoctorsController < ApplicationController
  before_action :authenticate_user!
  load_and_authorize_resource
  def index
    @categories = Category.all
    @doctors = if params[:category_ids].present? && params[:category_ids] != ""
                  Doctor.joins(:categories).where('categories.id IN (?)', params[:category_ids])
                else
                    Doctor.all
                end
  end

  def show
    @doctor = Doctor.find(params[:id])
  end
end
