class UsersController < ApplicationController
  before_action :find_user, only: [ :edit, :update, :lock,:unlock ]
  before_action :require_admin, only: [ :lock, :unlock ]
  skip_before_action :finish_profile, only: [ :edit, :update, :select_country ]

  def index
    @users = User.all_except(current_user)
    if current_user.is_admin
      render "index", layout: "admin_application"
    end
  end

  def show
    @user_show = User.find(params[:id])
    if @user_show.is_lock
      flash[:notice] = "This user is locked!"
      redirect_back(fallback_location: root_path)
    else
      @posts = @user_show.posts.all_active.order("created_at desc")
      @post = Post.new
      if @user_show == current_user
        @is_my_profile = true
      else
        @is_my_profile = false
      end
    end
  end

  def edit
    @countries = Country.all
    if current_user.country
      @cities = current_user.country.cities
    else
      @cities = @countries.first.cities
    end
  end

  def update
    if @user.update_attributes(user_params)
      flash[:notice] = "Your profile has been update!"
      redirect_to user_path
    else
      flash[:notice] = @user.errors
      redirect_back(fallback_location: root_path)
    end
  end

  def lock
    @user.lock
    @user.save
    flash[:notice] = "Lock user complete!"
    redirect_back(fallback_location: root_path)
  end

  def unlock
    @user.unlock
    @user.save
    flash[:notice] = "Unlock user complete!"
    redirect_back(fallback_location: root_path)
  end

  def select_country
    @country = Country.find(params[:user][:country_id])
    @cities = @country.cities
    # render :nothing => true, :status => 200, :content_type => 'text/html'
  end

  private
  def user_params
  	params.require(:user).permit(:name, :avatar, :cover_photo, :color, :email, :country_id, :city_id, :date_of_birth, :password, :password_confirmation)
  end

  def find_user
    @user = User.find(params[:id])
  end
end
