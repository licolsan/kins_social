require 'rails_helper'

RSpec.describe Post, type: :model do
	it "ensure content presence" do
  		post = Post.new(title: "abc", content: "abc").save
  		expect(post).to eq(false)
  	end
  context "validation tests" do
  	it "ensure title presence" do
  		user = User.create(provider: "abc", uid: "abc", name: "abc", email: "a@a", password: "123", password_confirmation: "123", activated: true)
  		post = Post.new(user: user, title: "", content: "abc").save
  		expect(post).to eq(false)
  	end
  	it "ensure content presence" do
  		user = User.create(provider: "abc", uid: "abc", name: "abc", email: "a@a", password: "123", password_confirmation: "123", activated: true)
  		post = Post.new(user: user, title: "abc", content: "").save
  		expect(post).to eq(false)
  	end
  end
end
