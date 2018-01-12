class AccountActivationsController < ApplicationController
	def edit
		user = User.find_by(email: params[:email])
    if user && !user.is_activated? && user.authenticated?(params[:id])
      user.activate
      session[:user_id] = user.id
      flash[:notice] = "Account activated!"
      redirect_to root_url
    else
      flash[:notice] = "Invalid activation link"
      redirect_to root_url
    end
	end
end
