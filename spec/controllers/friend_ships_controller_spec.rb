require 'rails_helper'

RSpec.describe FriendShipsController, type: :controller do
  context "List friends" do
  	it "without authenticate" do
  		get :index
  		expect(response).to redirect_to(log_in_path)
  	end
  	it "with authenticate" do
  		user = User.create(provider: "abc", uid: "abc", name: "abc", email: "a@a", password: "123456", password_confirmation: "123456", confirmed_at: Date.today)
  		session[:user_id] = user.id
  		get :index
  		expect(response).to be_success
  	end
  end
  context "Send friend request" do
  	it "sent" do
  		user1 = User.create(provider: "abc", uid: "abc", name: "abc", email: "a@a", password: "123456", password_confirmation: "123456", confirmed_at: Date.today)
  		user2 = User.create(provider: "abc", uid: "abc", name: "cba", email: "b@b", password: "123456", password_confirmation: "123456", confirmed_at: Date.today)
  		session[:user_id] = user1.id
  		post :create, params: { id: user2.id }
  		expect(FriendShip.find_by(sender_id: user1.id, receiver_id: user2.id)).not_to be_nil
  	end
  	it "send friend request failed" do
  		user1 = User.create(provider: "abc", uid: "abc", name: "abc", email: "a@a", password: "123456", password_confirmation: "123456", confirmed_at: Date.today)
  		user2 = User.create(provider: "abc", uid: "abc", name: "cba", email: "b@b", password: "123456", password_confirmation: "123456", confirmed_at: Date.today)
  		session[:user_id] = user1.id
  		post :create, params: { id: -1 }
  		expect(FriendShip.find_by(sender_id: user1.id, receiver_id: user2.id)).to be_nil
  	end
  end
  context "Accept friend request" do
  	it "accepted" do
  		user1 = User.create(provider: "abc", uid: "abc", name: "abc", email: "a@a", password: "123456", password_confirmation: "123456", confirmed_at: Date.today)
  		user2 = User.create(provider: "abc", uid: "abc", name: "cba", email: "b@b", password: "123456", password_confirmation: "123456", confirmed_at: Date.today)
  		session[:user_id] = user1.id
  		friend_ship = FriendShip.create(sender: user2, receiver: user1)
  		post :accept, params: { id: user2.id }
  		expect(FriendShip.find(friend_ship.id).status).to be 1
  	end
  end
  context "Deny friend" do
  	it "denied" do
  		user1 = User.create(provider: "abc", uid: "abc", name: "abc", email: "a@a", password: "123456", password_confirmation: "123456", confirmed_at: Date.today)
  		user2 = User.create(provider: "abc", uid: "abc", name: "cba", email: "b@b", password: "123456", password_confirmation: "123456", confirmed_at: Date.today)
  		session[:user_id] = user1.id
  		friend_ship = FriendShip.create(sender: user2, receiver: user1)
  		post :deny, params: { id: user2.id }
  		expect(FriendShip.where(id: friend_ship.id).size).to be 0
  	end
  end
  context "Block friend" do
  	it "blocked" do
  		user1 = User.create(provider: "abc", uid: "abc", name: "abc", email: "a@a", password: "123456", password_confirmation: "123456", confirmed_at: Date.today)
  		user2 = User.create(provider: "abc", uid: "abc", name: "cba", email: "b@b", password: "123456", password_confirmation: "123456", confirmed_at: Date.today)
  		session[:user_id] = user1.id
  		friend_ship = FriendShip.create(sender: user2, receiver: user1, status: 1)
  		post :block, params: { id: user2.id }
  		expect(FriendShip.find(friend_ship.id).status).to be 2
  	end
  end
  context "Unblock friend" do
  	it "unblocked" do
  		user1 = User.create(provider: "abc", uid: "abc", name: "abc", email: "a@a", password: "123456", password_confirmation: "123456", confirmed_at: Date.today)
  		user2 = User.create(provider: "abc", uid: "abc", name: "cba", email: "b@b", password: "123456", password_confirmation: "123456", confirmed_at: Date.today)
  		session[:user_id] = user1.id
  		friend_ship = FriendShip.create(sender: user2, receiver: user1, status: 2)
  		post :unblock, params: { id: user2.id }
  		expect(FriendShip.find(friend_ship.id).status).to be 1
  	end
  end
  context "Unfriend" do
  	it "unfriended" do
  		user1 = User.create(provider: "abc", uid: "abc", name: "abc", email: "a@a", password: "123456", password_confirmation: "123456", confirmed_at: Date.today)
  		user2 = User.create(provider: "abc", uid: "abc", name: "cba", email: "b@b", password: "123456", password_confirmation: "123456", confirmed_at: Date.today)
  		session[:user_id] = user1.id
  		friend_ship = FriendShip.create(sender: user2, receiver: user1, status: 1)
  		post :unfriend, params: { id: user2.id }
  		expect(FriendShip.where(id: friend_ship.id).size).to be 0
  	end
  end
end
