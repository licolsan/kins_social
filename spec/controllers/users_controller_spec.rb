require 'rails_helper'


RSpec.describe UsersController, type: :controller do
	context "Sign up" do
		it "signup page" do
			get :new
			expect(response).to be_success
		end

		it "sign up complete" do
			post :create, :params => { :user => { name: "abc", email: "a@a", password: "123", password_confirmation: "123" } }
			expect(response).to redirect_to(root_path)
		end

		it "sign up failed" do
			post :create, :params => { :user => { name: "abc", email: "a@a", password: "123", password_confirmation: "321" } }
			expect(response).to be_success
		end
	end

	context "Update profile" do
		it "go to edit page" do
			user = User.create(provider: "abc", uid: "abc", name: "abc", email: "a@a", password: "123", password_confirmation: "123", activated: true)
			session[:user_id] = user.id
			get :edit, :params => { id: user.id }
			expect(response).to be_success
		end
		it "update complete" do
			user = User.create(provider: "abc", uid: "abc", name: "abc", email: "a@a", password: "123", password_confirmation: "123", activated: true)
			session[:user_id] = user.id
			put :update, :params => { id: user.id, :user => {name: "def", avatar: "01.png", cover_photo: "", color: "", email: "b@b"} }
			expect(user.errors.size).to eq 0
		end
		it "update failed" do
			user = User.create(provider: "abc", uid: "abc", name: "abc", email: "a@a", password: "123", password_confirmation: "123", activated: true)
			session[:user_id] = user.id
			put :update, :params => { id: user.id, :user => {name: "def", avatar: "", cover_photo: "", color: "", email: ""} }
			expect(user.errors.size).to eq 0
		end
	end

	it "List all user" do
		user = User.create(provider: "abc", uid: "abc", name: "abc", email: "a@a", password: "123", password_confirmation: "123", activated: true)
		session[:user_id] = user.id
		get :index
		expect(response).to be_success
	end
end
