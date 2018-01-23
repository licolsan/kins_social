class ChannelsController < ApplicationController
  def show
    @senders = current_user.get_friend_senders
    @receivers = current_user.get_friend_receivers
    @other_user = User.find(params[:user_id])
    @channel = Channel.find(params[:id])
    @message = Message.new
  end

  def create
  	other_user = User.find(params[:user_id])
  	channel = find_channel(other_user) || Channel.new
  	if !channel.persisted?
  		channel.save
  		channel.subscriptions.create(user_id: current_user.id)
  		channel.subscriptions.create(user_id: other_user.id) if other_user.id != current_user.id
  	end
  	redirect_to user_channel_path(other_user, channel)
  end

  private
  def find_channel(other_user)
  	current_user.channels.each do |channel|
  		channel.subscriptions.each do |subscription|
  			if subscription.user_id == other_user.id
  				return channel
  			end
  		end
  	end
  	nil
  end
end
