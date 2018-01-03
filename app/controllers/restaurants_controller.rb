class RestaurantsController < ApplicationController
  before_action :set_restaurant, only: [:show, :dashboard, :favorite, :unfavorite, :like, :unlike]


  def index
    @restaurants = Restaurant.page(params[:page]).per(9)
    @categories = Category.all
  end

  def show
    @restaurant = Restaurant.find(params[:id])
    @comment = Comment.new    
  end

  def feeds
    @recent_restaurants = Restaurant.order(created_at: :desc).limit(10)
    @recent_comments = Comment.order(created_at: :desc).limit(10)
  end


  def dashboard
  end

  def favorite
    Favorite.create(restaurant: @restaurant, user: current_user)
    redirect_back(fallback_location: root_path)
  end

  def unfavorite
    favorites = Favorite.where(restaurant: @restaurant, user: current_user)
    favorites.destroy_all
    redirect_back(fallback_location: root_path)
  end

  def like
    Like.create(restaurant: @restaurant, user:current_user)
    redirect_back(fallback_location: root_path)
  end

  def unlike
    likes = Like.where(restaurant: @restaurant, user: current_user)
    likes.destroy_all
    redirect_back(fallback_location: root_path)
  end

  private

  def set_restaurant
    @restaurant = Restaurant.find(params[:id])
  end

end


