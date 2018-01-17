require 'rails_helper'

RSpec.describe Post, type: :model do
  before(:each) do
    @user = (User.create(provider: "abc", uid: "abc", name: "abc", email: "a@a", password: "123456", password_confirmation: "123456", confirmed_at: Date.today) || User.find_by(email: "a@a"))
    @post = Post.create(title: "Say hello", content: "Just say hello", user_id: @user.id)
  end
	it "ensure content presence" do
  		post = Post.new(title: "abc", content: "abc").save
  		expect(post).to eq(false)
  	end
  context "validation tests" do
  	it "ensure title presence" do
  		user = User.create(provider: "abc", uid: "abc", name: "abc", email: "a@a", password: "123456", password_confirmation: "123456", confirmed_at: Date.today)
  		post = Post.new(user: user, title: "", content: "abc").save
  		expect(post).to eq(false)
  	end
  	it "ensure content presence" do
  		user = User.create(provider: "abc", uid: "abc", name: "abc", email: "a@a", password: "123456", password_confirmation: "123456", confirmed_at: Date.today)
  		post = Post.new(user: user, title: "abc", content: "").save
  		expect(post).to eq(false)
  	end
  end
  it "get comments" do
    @post.get_comments
  end
  it "get comment number" do
    @post.get_comment_number
  end
  it "is reacted by" do
    expect(@post.is_reacted_by(@user)).to be false
  end
  it "get react number" do
    expect(@post.get_react_number).to be >= 0
  end
end
