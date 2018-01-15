require 'rails_helper'

RSpec.describe OmniauthCallbacksController, type: :controller do
	# before(:each) do
	# 	@user = User.create(provider: "abc", uid: "abc", name: "abc", email: "a@a", password: "123456", password_confirmation: "123456", confirmed_at: Date.today)
	# 	@other_user = User.create(provider: "abc", uid: "cba", name: "cba", email: "b@b", password: "123456", password_confirmation: "123456", confirmed_at: Date.today)
	# end
	before do
		@request.env["devise.mapping"] = Devise.mappings[:user]
	end

	context "provider" do
		it "facebook callback" do
			get :facebook, params:  request.env["omniauth.auth"] = OmniAuth.config.mock_auth[:facebook]
		end
		it "google_oauth2 callback" do
			get :google_oauth2, params:  request.env["omniauth.auth"] = OmniAuth.config.mock_auth[:google_oauth2]
		end
	end
end
