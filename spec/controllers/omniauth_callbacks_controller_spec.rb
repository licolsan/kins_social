require 'rails_helper'

RSpec.describe OmniauthCallbacksController, type: :controller do
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
