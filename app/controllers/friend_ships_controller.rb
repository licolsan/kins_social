class FriendShipsController < ApplicationController
	before_action :require_user
	before_action :get_friend_ship, only: [ :create, :accept, :deny, :block, :unblock, :unfriend ]
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
		redirect_to users_path
	end

	def accept
		@friendship.accept
		@friendship.save
		flash[:notice] = "Accept friend success!"
		redirect_to friend_ships_path
	end

	def deny
		@friendship.destroy
		flash[:notice] = "Deny friend success!"
		redirect_to friend_ships_path
	end

	def block
		@friendship.block
		@friendship.save
		flash[:notice] = "Block friend success!"
		redirect_to friend_ships_path
	end

	def unblock
		@friendship.unblock
		@friendship.save
		flash[:notice] = "Unblock friend success!"
		redirect_to friend_ships_path
	end

	def unfriend
		@friendship.unfriend
		flash[:notice] = "Unfriend success!"
		redirect_to friend_ships_path
	end

	private
	def get_friend_ship
		@friendship = FriendShip.find_by("(sender_id = ? AND receiver_id = ?) OR (sender_id = ? AND receiver_id = ?)", params[:id], current_user.id, current_user.id, params[:id])
	end
end
