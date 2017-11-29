class Admin::RestaurantsController < ApplicationController

  before_action :authenticate_user!
  before_action :authenticate_admin
  before_action :set_restaurant, only: [:show, :edit, :update, :destroy]


  def index
    @restaurants = Restaurant.page(params[:page]).per(10)
  end

  def new
    @restaurant = Restaurant.new
  end

  def create
    @restaurant = Restaurant.new(restaurant_params)
    if @restaurant.save
      flash[:notice] = "restaurant was successfully created"
      redirect_to admin_restaurants_path
    else
      flash.now[:alert] = "restaurant was failed to create"
      render :new
    end
  end

  def update
    if @restaurant.update(restaurant_params)
      flash[:notice] = "restaurant has been successfully updated"
      redirect_to admin_restaurant_path(@restaurant)    
    else
      flash[:alert] = "restaurant was failed to update"
      render :edit
    end    
  end

  def destroy
    @restaurant.destroy
    redirect_to_back_or_default
  end

  def redirect_to_back_or_default
    if request.env["HTTP_REFERER"].present? and request.env["HTTP_REFERER"] != request.env["REQUEST_URI"]
      redirect_to request.referer, :notice => "#{@restaurant.name} was successfully deleted."
    else
      redirect_to admin_restaurants_path, :notice => "#{@restaurant.name} was successfully deleted."
    end
  end



  private

  def restaurant_params
    params.require(:restaurant).permit(:name, :tel, :address, :opening_hours, :description, :image)
  end

  def set_restaurant
    @restaurant = Restaurant.find(params[:id])
  end
end
