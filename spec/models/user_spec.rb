require 'rails_helper'

RSpec.describe User, type: :model do
	before(:each) do
		@user = User.create(provider: "abc", uid: "abc", name: "abc", email: "a@a", password: "123456", password_confirmation: "123456", confirmed_at: Date.today)
		@other_user = User.create(provider: "abc", uid: "cba", name: "cba", email: "b@b", password: "123456", password_confirmation: "123456", confirmed_at: Date.today)
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
