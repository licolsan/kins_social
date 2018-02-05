require 'rails_helper'

RSpec.describe FollowRelationshipsController, type: :controller do
	before(:each) do
		sign_in @user = create(:user)
		@other_user = create(:user)
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
