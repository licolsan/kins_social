class SessionsController < ApplicationController
  skip_before_action :verify_authenticity_token

	def new
	end

	def login_to
		@user = User.find_by(email: params[:sess][:email])
		
		if @user && @user.authenticate(params[:sess][:password]) && @user.is_activated?

			session[:user_id] = @user.id
			redirect_to root_path, notice: "Logged in"
		else
			flash[:notice] = "Invalid email or password"
			render 'new'
		end
	end

	def create
		auth = request.env['omniauth.auth']
		user = User.sign_in_from_omniauth(auth)
		session[:user_id] = user.id
		redirect_to root_path, notice: "Logged in"
	end

	def destroy
		#session.delete(:user_id)
		session[:user_id] = nil
		redirect_to root_path, notice: "Logged out"
	end
end
