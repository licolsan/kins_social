class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  before_action :authenticate_user!
  before_action :finish_profile, if: :authenticate_user!
  before_action :configure_permitted_parameters, if: :devise_controller?
  helper_method :all_friend_request, :all_waiters

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name])
  end

  private
  def all_friend_request
		@all_friend_request ||= current_user.get_waiter_number if current_user.get_waiter_number > 0
  end

  def all_waiters
  	@waiters ||= current_user.get_waiters
  end

  def require_admin
    redirect_to root_path unless current_user.is_admin
  end

  def finish_profile
    if current_user.avatar.blank? || current_user.cover_photo.blank? || current_user.country.blank? || current_user.city.blank? || current_user.date_of_birth.blank?
      flash[:notice] = "You need to update profile before continue"
      redirect_to edit_user_path(current_user)
    end
  end
end
