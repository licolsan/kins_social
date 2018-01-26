class MemberShipsController < ApplicationController
	before_action :find_group

	def new
		@senders = current_user.get_friend_senders
		@receivers = current_user.get_friend_receivers
	end

	def create
		unless params[:user_id]
			flash[:notice] = "Please choose person!"
      redirect_back(fallback_location: root_path)
		else
			params[:user_id].each do |id|
				@group.member_ships.create(user_id: id)
			end
			flash[:notice] = "Add member complete!"
			redirect_back(fallback_location: root_path)
		end
	end

	def destroy
		member_ship = @group.member_ships.find_by(user_id: params[:id])
		member_ship.destroy
    redirect_back(fallback_location: root_path)
	end

	private
	def find_group
		@group = Group.find(params[:group_id])
	end
end
