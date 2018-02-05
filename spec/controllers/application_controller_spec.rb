require 'rails_helper'

RSpec.describe ApplicationController, type: :controller do
	before(:each) do
		sign_in @user = create(:user)
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
