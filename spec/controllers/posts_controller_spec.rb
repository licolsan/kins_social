require 'rails_helper'

RSpec.describe PostsController, type: :controller do
	before(:each) do
		sign_in @user = User.create(provider: "abc", uid: "abc", name: "abc", email: "a@a", password: "123456", password_confirmation: "123456", confirmed_at: Date.today)
		@post = Post.create(user_id: @user.id, title: "def", content: "def")
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
			post :update, :params => { id: @post.id, :post => { user_id: @user.id, title: "abc", content: "abc" } }
  		expect(Post.find(@post.id).title).to eq "abc"
		end
		it "update post failed" do
			post :update, :params => { id: @post.id, :post => { user_id: @user.id, title: "", content: "abc" } }
  		expect(Post.find(@post.id).title).to eq "def"
		end
		it "delete post" do
			delete :destroy, :params => { id: @post.id }
  		expect(Post.where(id: @post.id).size).to eq 0
		end
	end

	context "Mark remove (admin)" do
		it "report count < 5" do
			@user.is_admin = true
			@user.save
			post :mark_remove, params: { id: @post.id }
			expect(Post.find(@post.id).is_marked_remove).to eq false
		end
		it "report count > 5" do
			@user.is_admin = true
			@user.save

			@user1 = User.create(provider: "abc", uid: "abc", name: "abc", email: "a@a", password: "123456", password_confirmation: "123456", confirmed_at: Date.today)
			@user2 = User.create(provider: "abc", uid: "abc", name: "abc", email: "b@b", password: "123456", password_confirmation: "123456", confirmed_at: Date.today)
			@user3 = User.create(provider: "abc", uid: "abc", name: "abc", email: "c@c", password: "123456", password_confirmation: "123456", confirmed_at: Date.today)
			@user4 = User.create(provider: "abc", uid: "abc", name: "abc", email: "d@d", password: "123456", password_confirmation: "123456", confirmed_at: Date.today)
			@user5 = User.create(provider: "abc", uid: "abc", name: "abc", email: "e@e", password: "123456", password_confirmation: "123456", confirmed_at: Date.today)

			@report = @post.reports.create(user: @user, reason: "abc")
			@report = @post.reports.create(user: @user1, reason: "abc")
			@report = @post.reports.create(user: @user2, reason: "abc")
			@report = @post.reports.create(user: @user3, reason: "abc")
			@report = @post.reports.create(user: @user4, reason: "abc")
			@report = @post.reports.create(user: @user5, reason: "abc")
			
			post :mark_remove, params: { id: @post.id }
			expect(Post.find(@post.id).is_marked_remove).to eq true
		end
	end

	context "Unmark remove (admin)" do
		it "Unmarked" do
			@post.is_marked_remove = true
			@post.save
			post :unmark_remove, params: { id: @post.id }
			expect(Post.find(@post.id).is_marked_remove).to eq false
		end
	end
end
