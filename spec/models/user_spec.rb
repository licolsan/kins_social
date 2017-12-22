require 'rails_helper'

RSpec.describe User, type: :model do
  context "validation tests" do
  	it "ensure name presence" do
  		user = User.create(provider: "abc", uid: "abc", email: "a@a", password: "123").save
  		expect(user).to eq(false)
  	end

  	it "ensure email presence" do
  		user = User.create(provider: "abc", uid: "abc", name: "abc", password: "123").save
  		expect(user).to eq(false)
  	end

  	it "ensure unique email" do
  		user1 = User.create(provider: "abc", uid: "abc", name: "abc", email: "a@a", password: "123").save
  		user2 = User.create(provider: "abc", uid: "abc", name: "abc", email: "a@a", password: "123").save
  		expect(user2).to eq(false)
  	end

  	it "ensure password presence" do
  		user = User.create(provider: "abc", uid: "abc", name: "abc", email: "a@a").save
  		expect(user).to eq(false)
  	end

	  it "ensure password is confirmed" do
		  user = User.create(provider: "abc", uid: "abc", name: "abc", email: "a@a", password: "123", password_confirmation: "321").save
		  expect(user).to eq(false)
  	end  	
  end
end
