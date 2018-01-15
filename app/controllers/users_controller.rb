class UsersController < ApplicationController
  before_action :require_user, only: [ :index, :edit, :update ]

  def index
    @users = User.all_except(current_user)
  end

  def show
    @user_show = User.find(params[:id])
    @posts = @user_show.posts
    @post = Post.new
    if @user_show == current_user
      @is_my_profile = true
    else
      @is_my_profile = false
    end
  end

  def edit
  end

  def update
    @user = User.find(params[:id])
    if @user.update_attributes(user_params)
      flash[:notice] = "Your profile has been update!"
      redirect_to user_path
    else
      render 'edit'
    end
  end

  private
  def user_params
  	params.require(:user).permit(:name, :avatar, :cover_photo, :color, :email, :password, :password_confirmation)
  end
end
