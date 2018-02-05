require 'rails_helper'

RSpec.describe FriendShipsController, type: :controller do
  before(:each) do
    sign_in @user = create(:user)
		@other_user = create(:user)
  end

  context "List friends" do
  	it "without authenticate" do
  		get :index
      session[:user_id] = nil
  		expect(response).to be_success
  	end
  	it "with authenticate" do
  		get :index
  		expect(response).to be_success
  	end
  end
  context "Send friend request" do
  	it "sent" do
  		post :create, params: { id: @other_user.id }
  		expect(FriendShip.find_by(sender_id: @user.id, receiver_id: @other_user.id)).not_to be_nil
  	end
  	it "send friend request failed" do
  		post :create, params: { id: -1 }
  		expect(FriendShip.find_by(sender_id: @user.id, receiver_id: @other_user.id)).to be_nil
  	end
  end
  context "Accept friend request" do
  	it "accepted" do
  		friend_ship = FriendShip.create(sender: @other_user, receiver: @user)
  		post :accept, params: { id: @other_user.id }
  		expect(FriendShip.find(friend_ship.id).status).to be 1
  	end
  end
  context "Deny friend" do
  	it "denied" do
  		friend_ship = FriendShip.create(sender: @other_user, receiver: @user)
  		post :deny, params: { id: @other_user.id }
  		expect(FriendShip.where(id: friend_ship.id).size).to be 0
  	end
  end
  context "Block friend" do
  	it "blocked" do
  		friend_ship = FriendShip.create(sender: @other_user, receiver: @user, status: 1)
  		post :block, params: { id: @other_user.id }
  		expect(FriendShip.find(friend_ship.id).status).to be 2
  	end
  end
  context "Unblock friend" do
  	it "unblocked" do
  		friend_ship = FriendShip.create(sender: @other_user, receiver: @user, status: 2)
  		post :unblock, params: { id: @other_user.id }
  		expect(FriendShip.find(friend_ship.id).status).to be 1
  	end
  end
  context "Unfriend" do
  	it "unfriended" do
  		friend_ship = FriendShip.create(sender: @other_user, receiver: @user, status: 1)
  		post :unfriend, params: { id: @other_user.id }
  		expect(FriendShip.where(id: friend_ship.id).size).to be 0
  	end
  end
end
