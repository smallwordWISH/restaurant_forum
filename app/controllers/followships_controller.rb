class FollowshipsController < ApplicationController

  def create
    @followship = current_user.followships.build(following_id: params[:following_id])
    @user = User.find(params[:following_id])

    if @followship.save
      flash[:notice] = "Successfully followed #{@user.name}"
    else
      flash[:alert] = @followship.errors.full_messages.to_sentence
    end
    
    @user.count_followers

    redirect_back(fallback_location: users_path)
  end

  def destroy
    @followship = current_user.followships.where(following_id: params[:id])
    @followship.destroy_all

    @user = User.find(params[:id])
    @user.count_followers
    flash[:notice] = "Successfully unfollowed #{@user.name}"

    redirect_back(fallback_location: users_path)
  end
end
