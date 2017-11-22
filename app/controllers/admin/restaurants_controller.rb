class Admin::RestaurantsController < ApplicationController

  before_action :authenticate_user!
  before_action :authenticate_admin
  before_action :set_restaurant, only: [:show, :edit, :update]


  def index
    @restaurants = Restaurant.all
  end

  def new
    @restaurant = Restaurant.new
  end

  def create
    @restaurant = Restaurant.new(restaurant_params)
    if @restaurant.save
      redirect_to admin_restaurants_path
      flash[:notice] = "restaurant was successfully created" 
    else
      render :new
      flash[:alert] = "restaurant was failed to create"
    end
  end

  def update
    if @restaurant.update(restaurant_params)
      redirect_to admin_restaurant_path(@restaurant)
      flash[:notice] = "restaurant has been successfully updated"
    else
      render :edit
      flash[:alert] = "restaurant was failed to update"
    end    
  end



  private

  def restaurant_params
    params.require(:restaurant).permit(:name, :tel, :address, :opening_hours, :description)
  end

  def set_restaurant
    @restaurant = Restaurant.find(params[:id])
  end
end
