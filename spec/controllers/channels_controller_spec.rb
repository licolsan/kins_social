require 'rails_helper'

RSpec.describe ChannelsController, type: :controller do
	before(:each) do
		sign_in @user = User.create(provider: "abc", uid: "abc", name: "abc", email: "a@a", password: "123456", password_confirmation: "123456", confirmed_at: Date.today)
		@other_user = User.create(provider: "abc", uid: "cba", name: "cba", email: "b@b", password: "123456", password_confirmation: "123456", confirmed_at: Date.today)
	end

	context "Create channel" do
		it "have no channel before" do
			channel = Channel.new
			channel.save
			channel.subscriptions.create(user_id: @user.id)
			channel.subscriptions.create(user_id: @other_user.id)
			post :create, params: { user_id: @other_user.id }
			subscription_1 = Subscription.find_by(user_id: @user.id)
			subscription_2 = Subscription.find_by(user_id: @other_user.id)
			expect(subscription_1.channel_id).to eq subscription_2.channel_id
		end
		it "have channel before" do

			post :create, params: { user_id: @other_user.id }
			subscription_1 = Subscription.find_by(user_id: @user.id)
			subscription_2 = Subscription.find_by(user_id: @other_user.id)
			expect(subscription_1.channel_id).to eq subscription_2.channel_id
		end
		
	end

	it "Show channel" do
		channel = Channel.new
		channel.save
		channel.subscriptions.create(user_id: @user.id)
		channel.subscriptions.create(user_id: @other_user.id)
		get :show, params: { user_id: @other_user.id, id: channel.id }
		expect(Channel.where(id: channel.id).size).to be > 0
	end
end
