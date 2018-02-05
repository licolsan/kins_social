require 'rails_helper'


RSpec.describe UsersController, type: :controller do
	before(:each) do
		sign_in @user = create(:user)
		@other_user = create(:user)
	end

	context "Update profile" do
		it "go to edit page" do
			get :edit, :params => { id: @user.id }
			expect(response).to be_success
		end
		it "update complete" do
			put :update, :params => { id: @user.id, :user => {name: "abc", avatar: "", cover_photo: "", color: ""} }
			expect(User.find(@user.id).errors.size).to eq 0
		end
		it "update failed" do
			put :update, :params => { id: @user.id, :user => {name: "def", avatar: "", cover_photo: "", color: "", email: ""} }
			expect(User.find(@user.id).errors.size).to eq 0
		end
		it "country live" do
			get :select_country, params: { id: @user.id, user: { country_id:  @user.country.id} }
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

	it "list all user without update profile" do
		sign_in @other_user = User.create(provider: "abc", uid: "cba", name: "cba", email: "b@b", password: "123456", password_confirmation: "123456", confirmed_at: Date.today)
		get :index
	end
end
