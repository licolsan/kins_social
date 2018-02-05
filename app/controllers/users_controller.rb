class UsersController < ApplicationController
  skip_before_action :finish_profile, only: [ :edit, :update ]

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
    @countries = Country.all
    @cities = current_user.country.cities
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

  def select_country
    @country = Country.find(params[:user][:country_id])
    @cities = @country.cities
    # render :json => {:success => true}
    render :nothing => true, :status => 200, :content_type => 'text/html'
  end

  private
  def user_params
  	params.require(:user).permit(:name, :avatar, :cover_photo, :color, :email, :country_id, :city_id, :date_of_birth, :password, :password_confirmation)
  end
end
