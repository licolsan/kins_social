require 'rails_helper'

RSpec.describe User, type: :model do
	before(:each) do
		@user = create(:user)
		@other_user = create(:user)
	end

	it "Identify friend" do
    expect(@user.is_friend?(@other_user)).to eq false
  end
  context "Follow relationship" do
    it "get follower list" do
      @user.get_followers
    end
    it "get following list" do
      @user.get_followings
    end
    it "check if is following" do
      expect(@user.is_following?(@other_user)).to eq false
    end
  end
end
