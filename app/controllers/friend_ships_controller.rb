class FriendShipsController < ApplicationController
	before_action :require_user
	before_action :get_friend_ship, only: [ :accept, :deny, :block, :unblock, :unfriend ]
	before_action :create_follow_relationship, only: [ :accept ]
	before_action :delete_follow_relationship, only: [ :unfriend, :block ]

	def index
		@senders = current_user.get_friend_senders
		@receivers = current_user.get_friend_receivers
		@friend_count = current_user.get_friend_number

		@waiters = current_user.get_waiters
		@waiter_count = current_user.get_waiter_number

		@blocked_senders = current_user.get_blocked_senders
		@blocked_receivers = current_user.get_blocked_receivers
		@blocked_er_count = current_user.get_blocked_number
	end

	def create
		@friendship = FriendShip.new(sender_id: current_user.id, receiver_id: params[:id], status: 0)
		if @friendship.save
			flash[:notice] = "Request friend success!"
		else
			flash[:notice] = "Error when request friend!"
		end
		redirect_back(fallback_location: root_path)
	end

	def accept
		@friendship.accept
		@friendship.save
		flash[:notice] = "Accept friend success!"
		redirect_back(fallback_location: root_path)
	end

	def deny
		@friendship.destroy
		flash[:notice] = "Deny friend success!"
		redirect_back(fallback_location: root_path)
	end

	def block
		@friendship.block
		@friendship.save
		flash[:notice] = "Block friend success!"
		redirect_back(fallback_location: root_path)
	end

	def unblock
		@friendship.unblock
		@friendship.save
		flash[:notice] = "Unblock friend success!"
		redirect_back(fallback_location: root_path)
	end

	def unfriend
		@friendship.unfriend
		flash[:notice] = "Unfriend success!"
		redirect_back(fallback_location: root_path)
	end

	private
	def get_friend_ship
		@friendship = FriendShip.find_by("(sender_id = ? AND receiver_id = ?) OR (sender_id = ? AND receiver_id = ?)", params[:id], current_user.id, current_user.id, params[:id])
	end

	private
	def create_follow_relationship
		FollowRelationship.create(follower_id: current_user.id, followed_id: params[:id]) unless FollowRelationship.where(follower_id: current_user.id, followed_id: params[:id]).size > 0
		FollowRelationship.create(follower_id: params[:id], followed_id: current_user.id) unless FollowRelationship.where(follower_id: params[:id], followed_id: current_user.id).size > 0
	end

	private
	def delete_follow_relationship
		active_relationship = FollowRelationship.where(follower_id: current_user.id, followed_id: params[:id])
		passive_relationship = FollowRelationship.where(follower_id: params[:id], followed_id: current_user.id)
		active_relationship.delete_all if active_relationship.size > 0
		passive_relationship.delete_all if passive_relationship.size > 0
	end
end
