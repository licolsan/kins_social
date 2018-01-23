require 'rails_helper'

RSpec.describe MessagesController, type: :controller do
	before(:each) do
		sign_in @user = User.create(provider: "abc", uid: "abc", name: "abc", email: "a@a", password: "123456", password_confirmation: "123456", confirmed_at: Date.today)
		@other_user = User.create(provider: "abc", uid: "cba", name: "cba", email: "b@b", password: "123456", password_confirmation: "123456", confirmed_at: Date.today)
		@channel = Channel.new
		@channel.save
		@channel.subscriptions.create(user_id: @user.id)
		@channel.subscriptions.create(user_id: @other_user.id)
	end

	context "Create message" do
		it "created" do
			post :create, params: { message: { content: "abc", channel_id: @channel.id } }
			expect(Message.where(user_id: @user.id, content: "abc", channel_id: @channel.id).size).to be > 0
		end
		it "failed" do
			post :create, params: { message: { content: "abc", channel_id: "" } }
			expect(Message.where(user_id: @user.id, content: "abc", channel_id: @channel.id).size).to eq 0
		end
	end
end
