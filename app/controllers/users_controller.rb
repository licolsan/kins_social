class UsersController < ApplicationController
  def index
    @users = User.all_except(current_user)
  end
  
  def new
  	@user = User.new
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    @user.skip_password_validation = true
    if @user.update_attributes(user_params)
      flash[:notice] = "Your profile has been update!"
      redirect_to root_url
    else
      render 'edit'
    end
  end

  def create
  	@user = User.new(user_params)
  	if @user.save
      @user.send_activation_mail
      flash[:notice] = "Please check your email to activate your account"
      redirect_to root_url
  	else
  		render 'new'
  	end
  end

  private
  def user_params
  	params.require(:user).permit(:name, :avatar, :cover_photo, :color, :email, :password, :password_confirmation)
  end
end
