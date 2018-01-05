class FollowshipsController < ApplicationController

  def create
    @followship = current_user.followships.build(following_id: params[:following_id])

    if @followship.save
      flash[:notice] = "Successfully followed"
    else
      flash[:alert] = @followship.errors.full_messages.to_sentence
    end

    redirect_back(fallback_location: users_path)
  end

  def destroy
    @followship = current_user.followships.where(following_id: params[:id])
    @followship.destroy_all
    flash[:notice] = "Successfully unfollowed"

    redirect_to users_path
  end
end
