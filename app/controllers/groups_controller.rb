class GroupsController < ApplicationController
	before_action :find_group, only: [ :show, :edit, :update, :destroy ]

  def index
  	@groups = Group.all
  end

  def show
  end

  def new
  	@group = Group.new
  end

  def create
  	group = Group.new(group_params)
  	if group.save
  		group.member_ships.create(user_id: current_user.id, is_owner: true, is_admin: true)
  		flash[:notice] = "Create new group complete!"
  		redirect_to group_path(group)
  	else
  		flash[:notice] = "Create new groop failed!"
  		render 'new'
  	end
  end

  def edit
  end

  def update
  	if @group.update_attributes(group_params)
  		flash[:notice] = "Update group info complete!"
  	else
  		flash[:notice] = "Update group info failed!"
  	end
  	redirect_to group_path(@group)
  end

  def destroy
  	if @group.is_owned_by(current_user)
	  	@group.destroy
	  	flash[:notice] = "Delete group complete!"
	  	redirect_to user_path(current_user)
	  else
	  	flash[:notice] = "You are not the owner of the group!"
	  	redirect_back(fallback_location: root_path)
	  end
  end

  private
  def find_group
  	@group = Group.find(params[:id])
  end

  def group_params
  	params.require(:group).permit(:name, :avatar, :cover_photo, :group_type, :description)
  end
end
