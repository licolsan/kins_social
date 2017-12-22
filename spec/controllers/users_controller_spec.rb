require 'rails_helper'

RSpec.describe UsersController, type: :controller do
	context "Sign up" do
		it "signup page" do
			get :new
			expect(response).to be_success
		end

		it "sign up complete" do
			#user_attributes = { name: "abc", email: "a@a", password: "123", password_confirmation: "123" }
			post :create, :params => { :user => { name: "abc", email: "a@a", password: "123", password_confirmation: "123" } }
			expect(response).to redirect_to(root_path)
		end

		it "sign up failed" do
			#user_attributes = { name: "abc", email: "a@a", password: "123", password_confirmation: "123" }
			post :create, :params => { :user => { name: "abc", email: "a@a", password: "123", password_confirmation: "321" } }
			expect(response).to be_success
		end
	end
end
