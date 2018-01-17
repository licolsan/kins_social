require 'rails_helper'

RSpec.describe Comment, type: :model do
	before(:each) do
		@user = (User.create(provider: "abc", uid: "abc", name: "abc", email: "a@a", password: "123456", password_confirmation: "123456", confirmed_at: Date.today) || User.find_by(email: "a@a"))
		@post = Post.create(title: "Say hello", content: "Just say hello", user_id: @user.id)
		@comment = Comment.create(user_id: @user.id, post_id: @post.id, content: "abcdef")
	end

	context "Belong to" do
		it "true" do
			expect(@comment.is_belong_to(@user)).to eq true
		end
		it "false" do
			@other_user = (User.create(provider: "abc", uid: "abc", name: "abc", email: "b@b", password: "123456", password_confirmation: "123456", confirmed_at: Date.today) || User.find_by(email: "a@a"))
			expect(@comment.is_belong_to(@other_user)).to eq false
		end
	end

	context "Is reacted by" do
		it "true" do
			expect(@comment.is_reacted_by(@user)).to eq false
		end
	end

	it "get react number" do
		expect(@comment.get_react_number).to be >= 0
	end
end
