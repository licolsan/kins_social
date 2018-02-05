require 'rails_helper'

RSpec.describe CommentsController, type: :controller do
	before(:each) do
		sign_in @user = create(:user)
		@post = Post.create(title: "Say hello", content: "Just say hello", user_id: @user.id)
	end

	context "#create" do
		it "comment to post complete" do
			post :create, params: { post_id: @post.id, comment: { content: "Wow" } }
			@comment = Comment.find_by(user_id: @user.id, post_id: @post.id)
			expect(@comment.content).to eq "Wow"
		end

		it "comment to post failed" do
			@post = Post.create(title: "Say hello", content: "Just say hello", user_id: @user.id)
			post :create, params: { post_id: @post.id, comment: { content: "" } }
			@comment = Comment.where(user_id: @user.id, post_id: @post.id)
			expect(@comment.size).to eq 0
		end
	end
	it "#edit" do
		@comment = Comment.create(user_id: @user.id, post_id: @post.id, content: "abcdef")
		get :edit, params: {id: @comment.id}
	end
	context "#update" do
		it "updated" do
			@comment = Comment.create(user_id: @user.id, post_id: @post.id, content: "abcdef")
			post :update, params: { id: @comment.id, comment: { content: "fedcba" } }
			expect(Comment.find(@comment.id).content).to eq "fedcba"
		end
		it "updatee failed" do
			@comment = Comment.create(user_id: @user.id, post_id: @post.id, content: "abcdef")
			post :update, params: { id: @comment.id, comment: { content: "" } }
			expect(Comment.find(@comment.id).content).to eq "abcdef"
		end
	end
	it "#destroy" do
		@comment = Comment.create(user_id: @user.id, post_id: @post.id, content: "abcdef")
		delete :destroy, params: { id: @comment.id }
		expect(Comment.where(id: @comment.id).size).to eq 0
	end
end
