require 'rails_helper'

RSpec.describe ApplicationController, type: :controller do
	before(:each) do
		sign_in user = User.create(provider: "abc", uid: "abc", name: "abc", email: "a@a", password: "123456", password_confirmation: "123456", confirmed_at: Date.today)
	end

	context "Load all data on home page" do
		it "number of friend request" do
			subject.send(:all_friend_request)
		end
		it "get waiters" do
			subject.send(:all_waiters)
		end
		it "get users" do
			subject.send(:users)
		end
	end
end
