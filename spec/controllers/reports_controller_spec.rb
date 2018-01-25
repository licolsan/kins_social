require 'rails_helper'

RSpec.describe ReportsController, type: :controller do
	before(:each) do
		sign_in @user = User.create(provider: "abc", uid: "abc", name: "abc", email: "a@a", password: "123456", password_confirmation: "123456", confirmed_at: Date.today)
		@other_user = User.create(provider: "abc", uid: "cba", name: "cba", email: "b@b", password: "123456", password_confirmation: "123456", confirmed_at: Date.today)
		@post = Post.create(user_id: @other_user.id, title: "abc", content: "abc")
	end

	context "Write report" do
		it "report's already exist!" do
			@post.reports.create(user_id: @user.id, reason: "Bad content")
			post :create, params: { post_id: @post.id, report: { reason: "Not good content" } }
			expect(Report.where(user_id: @user.id, post_id: @post.id).size).to eq 1
		end
		it "reported" do
			post :create, params: { post_id: @post.id, report: { reason: "Not good content" } }
			expect(Report.where(user_id: @user.id, post_id: @post.id).size).to eq 1
		end
		it "report failed" do
			post :create, params: { post_id: @post.id, report: { reason: "" } }
			expect(Report.where(user_id: @user.id, post_id: @post.id).size).to eq 0
		end
	end
end
