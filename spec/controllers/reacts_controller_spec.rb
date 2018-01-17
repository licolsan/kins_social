require 'rails_helper'

RSpec.describe ReactsController, type: :controller do
	before(:each) do
		sign_in @user = User.create(provider: "abc", uid: "abc", name: "abc", email: "b@b", password: "123456", password_confirmation: "123456", confirmed_at: Date.today)
		@post = Post.create(title: "Say hello", content: "Just say hello", user_id: @user.id)
		@comment = Comment.create(user_id: @user.id, post_id: @post.id, content: "abcdef")
	end

	context "React for post" do
		it "reacted" do
			post :create, params: { react: { react_type: 1 }, post_id: @post.id }
			@react = React.where(user_id: @user.id, post_id: @post.id, react_type: 1)
			expect(@react.size).not_to eq 0
		end
		it "react failed" do
			post :create, params: { react: { react_type: nil }, post_id: @post.id }
			@react = React.where(user_id: @user.id, post_id: @post.id)
			expect(@react.size).to eq 0
		end
	end	

	context "React for comment" do
		it "reacted" do
			post :create, params: { comment_id: @comment.id, react: { react_type: 1 } }
			@react = React.where(user_id: @user.id, comment_id: @comment.id, react_type: 1)
			expect(@react.size).not_to eq 0
		end
	end

	it "#destroy" do
		@react = React.create(user_id: @user.id, comment_id: @comment.id, react_type: 1)
		delete :destroy, params: { id: @react.id }
		expect(React.where(id: @react.id).size).to eq 0
	end
end
