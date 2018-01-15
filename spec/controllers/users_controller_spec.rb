require 'rails_helper'


RSpec.describe UsersController, type: :controller do
	before(:each) do
		sign_in @user = User.create(provider: "abc", uid: "abc", name: "abc", email: "a@a", password: "123456", password_confirmation: "123456", confirmed_at: Date.today)
		@other_user = User.create(provider: "abc", uid: "cba", name: "cba", email: "b@b", password: "123456", password_confirmation: "123456", confirmed_at: Date.today)
	end

	context "Update profile" do
		it "go to edit page" do
			get :edit, :params => { id: @user.id }
			expect(response).to be_success
		end
		it "update complete" do
			patch :update, :params => { id: @user.id, :user => {name: "def", avatar: "01.png", cover_photo: "", color: "red", email: "a@a"} }
			expect(@user.errors.size).to eq 0
		end
		it "update failed" do
			put :update, :params => { id: @user.id, :user => {name: "def", avatar: "", cover_photo: "", color: "", email: ""} }
			expect(@user.errors.size).to eq 0
		end
	end

	context "Profile" do
		it "my profile" do
			get :show, :params => { id: @user.id }
		end
		it "other profile" do
			get :show, :params => { id: @other_user.id }
		end
	end

	it "List all user" do
		get :index
		expect(response).to be_success
	end
end
