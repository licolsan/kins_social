require 'rails_helper'


RSpec.describe UsersController, type: :controller do
	context "Update profile" do
		it "go to edit page" do
			user = User.create(provider: "abc", uid: "abc", name: "abc", email: "a@a", password: "123456", password_confirmation: "123456", confirmed_at: Date.today)
			session[:user_id] = user.id
			get :edit, :params => { id: user.id }
			expect(response).to be_success
		end
		it "update complete" do
			user = User.create(provider: "abc", uid: "abc", name: "abc", email: "a@a", password: "123456", password_confirmation: "123456", confirmed_at: Date.today)
			session[:user_id] = user.id
			put :update, :params => { id: user.id, :user => {name: "def", avatar: "01.png", cover_photo: "", color: "", email: "b@b"} }
			expect(user.errors.size).to eq 0
		end
		it "update failed" do
			user = User.create(provider: "abc", uid: "abc", name: "abc", email: "a@a", password: "123456", password_confirmation: "123456", confirmed_at: Date.today)
			session[:user_id] = user.id
			put :update, :params => { id: user.id, :user => {name: "def", avatar: "", cover_photo: "", color: "", email: ""} }
			expect(user.errors.size).to eq 0
		end
	end

	context "Profile" do
		it "my profile" do
			user = User.create(provider: "abc", uid: "abc", name: "abc", email: "a@a", password: "123456", password_confirmation: "123456", confirmed_at: Date.today)
			session[:user_id] = user.id
			get :show, :params => { id: user.id }
		end
		it "other profile" do
			user = User.create(provider: "abc", uid: "abc", name: "abc", email: "a@a", password: "123456", password_confirmation: "123456", confirmed_at: Date.today)
			other_user = User.create(provider: "abc", uid: "cba", name: "cba", email: "b@b", password: "123456", password_confirmation: "123456", confirmed_at: Date.today)
			session[:user_id] = user.id
			get :show, :params => { id: other_user.id }
		end
	end

<<<<<<< HEAD
	context "Update profile" do
		it "go to edit page" do
			user = User.create(provider: "abc", uid: "abc", name: "abc", email: "a@a", password: "123", password_confirmation: "123", activated: true)
			get :edit, :params => { id: user.id }
			expect(response).to be_success
		end
		it "update complete" do
			user = User.create(provider: "abc", uid: "abc", name: "abc", email: "a@a", password: "123", password_confirmation: "123", activated: true)
			put :update, :params => { id: user.id, :user => {name: "def", avatar: "01.png", cover_photo: "", color: "", email: "b@b"} }
			expect(user.errors.size).to eq 0
		end
		it "update failed" do
			user = User.create(provider: "abc", uid: "abc", name: "abc", email: "a@a", password: "123", password_confirmation: "123", activated: true)
			put :update, :params => { id: user.id, :user => {name: "def", avatar: "", cover_photo: "", color: "", email: ""} }
			expect(user.errors.size).to eq 0
		end
=======
	it "List all user" do
		user = User.create(provider: "abc", uid: "abc", name: "abc", email: "a@a", password: "123456", password_confirmation: "123456", confirmed_at: Date.today)
		session[:user_id] = user.id
		get :index
		expect(response).to be_success
>>>>>>> login_system
	end
end
