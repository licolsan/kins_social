class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  
  helper_method :current_user, :all_friend_request, :all_waiters

  private
  def all_friend_request
		@all_friend_request ||= current_user.get_waiter_number if current_user.get_waiter_number > 0
  end

  private
  def all_waiters
  	@waiters ||= current_user.get_waiters
  end

  private
  def current_user
  	@user ||= User.find(session[:user_id]) if session[:user_id]
  end

  def require_user
  	redirect_to log_in_path unless current_user
  end
end
