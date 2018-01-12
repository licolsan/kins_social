class OmniauthCallbacksController < Devise::OmniauthCallbacksController
	def facebook
		@user = User.form_omniauth(request.env["omniauth.auth"])
		sign_in_and_redirect @user
	end

	def google_oauth2
		@user = User.form_omniauth(request.env["omniauth.auth"])
		sign_in_and_redirect @user
	end
end