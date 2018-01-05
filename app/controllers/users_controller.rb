class UsersController < ApplicationController

  def show
    @user = User.find(params[:id])
    @commented_restaurants = @user.restaurants.uniq
  end

  def edit
    @user = User.find(params[:id])
    if @user != current_user
      flash[:alert] = "You are not authorized."
      redirect_to user_path(current_user)
    end
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      flash[:notice] = "user has been successfully updated"
      redirect_to user_path(@user)    
    else
      flash[:alert] = "user was failed to update"
      render :edit
    end 
  end

  def index
    @users = User.order(followers_count: :desc)
  end


  private

  def user_params
    params.require(:user).permit(:name, :intro, :avatar)
  end
end
