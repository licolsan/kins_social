require 'rails_helper'

RSpec.describe FollowRelationshipsController, type: :controller do
	before(:each) do
		sign_in @user = User.create(provider: "abc", uid: "abc", name: "abc", email: "a@a", password: "123456", password_confirmation: "123456", confirmed_at: Date.today)
		@other_user = User.create(provider: "abc", uid: "cba", name: "cba", email: "b@b", password: "123456", password_confirmation: "123456", confirmed_at: Date.today)
	end

	context "Edit relationship" do
		it "follow success" do
			post :create, :params => { id: @other_user.id }
			expect(FollowRelationship.where("(follower_id = ? AND followed_id = ?) OR (follower_id = ? AND followed_id = ?)", @user.id, @other_user.id, @other_user.id, @user.id).size).not_to eq 0
		end
		it "follow failed" do
			post :create, :params => { id: -1 }
			expect(FollowRelationship.where("(follower_id = ? AND followed_id = ?) OR (follower_id = ? AND followed_id = ?)", @user.id, @other_user.id, @other_user.id, @user.id).size).to eq 0
		end
		it "unfollow" do
			FollowRelationship.create(follower: @user, followed: @other_user)
			delete :destroy, :params => { id: @other_user.id }
			expect(FollowRelationship.where("(follower_id = ? AND followed_id = ?) OR (follower_id = ? AND followed_id = ?)", @user.id, @other_user.id, @other_user.id, @user.id).size).to eq 0
		end
	end
end