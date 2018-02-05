class FollowRelationshipsController < ApplicationController
	before_action :get_follow_relationship, only: [ :destroy ]

	def create
    @relationship = FollowRelationship.new(follower_id: current_user.id, followed_id: params[:id])
    if @relationship.save
    	flash[:notice] = "Follow user complete!"
    else
    	flash[:notice] = "Follow user failed!"
    end
    redirect_back(fallback_location: root_path)
  end

  def destroy
    @relationship.destroy
    flash[:notice] = "Unfollow user complete!"
    redirect_back(fallback_location: root_path)
  end

  private
  def get_follow_relationship
  	@relationship = FollowRelationship.find_by("(follower_id = ? AND followed_id = ?) OR (follower_id = ? AND followed_id = ?)", params[:id], current_user.id, current_user.id, params[:id])
  end
end
