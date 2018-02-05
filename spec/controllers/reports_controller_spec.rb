require 'rails_helper'

RSpec.describe ReportsController, type: :controller do
	before(:each) do
		sign_in @user = create(:user)
		@other_user = create(:user)
		@post = Post.create(user_id: @other_user.id, title: "abc", content: "abc")
	end

	it "List all report (admin)" do
		@user.is_admin = true
		@user.save
		get :index
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
