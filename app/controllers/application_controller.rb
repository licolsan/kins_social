class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  
  before_action :authenticate_user!
  before_action :configure_permitted_parameters, if: :devise_controller?

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name])
  end

  helper_method :all_friend_request, :all_waiters, :users

  private
  def users
    @users ||= User.all_except(current_user).last(10)
  end

  def all_friend_request
		@all_friend_request ||= current_user.get_waiter_number if current_user.get_waiter_number > 0
  end

  def all_waiters
  	@waiters ||= current_user.get_waiters
  end

  def require_user
  	redirect_to log_in_path unless current_user
  end
end
