require 'rails_helper'

RSpec.describe SessionsController, type: :controller do
	context "Log in" do
		it "Log in page" do
			get :new
			expect(response).to be_success
		end

		it "Log in complete" do
			user = User.create(provider: "abc", uid: "abc", name: "abc", email: "a@a", password: "123", password_confirmation: "123", activated: true)
			post :login_to, :params => { :sess => { email: user.email, password: user.password } }
			expect(session[:user_id]).to eq user.id
		end

		it "Log in failed (inactived)" do
			user = User.create(provider: "abc", uid: "abc", name: "abc", email: "a@a", password: "123", password_confirmation: "123")
			post :login_to, :params => { :sess => { email: user.email, password: user.password } }
			expect(session[:user_id]).to eq nil
		end

		it "Log in failed (wrong password)" do
			user = User.create(provider: "abc", uid: "abc", name: "abc", email: "a@a", password: "123", password_confirmation: "123")
			post :login_to, :params => { :sess => { email: user.email, password: "123456789" } }
			expect(session[:user_id]).to eq nil
		end

		it "Log in with facebook" do
			get :create, params:  request.env["omniauth.auth"] = OmniAuth.config.mock_auth[:facebook]
			expect(session[:user_id]).not_to eq nil
		end

		it "Log in with google" do
			get :create, params:  request.env["omniauth.auth"] = OmniAuth.config.mock_auth[:google_oauth2]
			expect(session[:user_id]).not_to eq nil
		end
	end

	context "Log out" do
		it "#destroy" do
			user = User.create(provider: "abc", uid: "abc", name: "abc", email: "a@a", password: "123", password_confirmation: "123")
			session[:user_id] = user.id
			delete :destroy
			expect(session[:user_id]).to eq nil
		end
	end
end
