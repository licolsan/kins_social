require 'rails_helper'

RSpec.describe PostsController, type: :controller do
	before(:each) do
		sign_in @user = User.create(provider: "abc", uid: "abc", name: "abc", email: "a@a", password: "123456", password_confirmation: "123456", confirmed_at: Date.today)
	end

	context "Crud with post" do
		it "create post success" do
			post :create, :params => { :post => { user_id: @user.id, title: "abc", content: "abc" } }
  		expect(Post.where(user_id: @user.id, title: "abc", content: "abc").size).to eq 1
		end
		it "create post failed" do
			post :create, :params => { :post => { user_id: @user.id, title: "", content: "abc" } }
  		expect(Post.where(user_id: @user.id, title: "abc", content: "abc").size).to eq 0
		end
		it "update post complete" do
			@post = Post.create(user_id: @user.id, title: "abc", content: "abc")
			post :update, :params => { id: @post.id, :post => { user_id: @user.id, title: "def", content: "abc" } }
  		expect(Post.find(@post.id).title).to eq "def"
		end
		it "update post failed" do
			@post = Post.create(user_id: @user.id, title: "abc", content: "abc")
			post :update, :params => { id: @post.id, :post => { user_id: @user.id, title: "", content: "abc" } }
  		expect(Post.find(@post.id).title).to eq "abc"
		end
		it "delete post" do
			@post = Post.create(user_id: @user.id, title: "abc", content: "abc")
			delete :destroy, :params => { id: @post.id }
  		expect(Post.where(id: @post.id).size).to eq 0
		end
	end
end
