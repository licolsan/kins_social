class ChannelsController < ApplicationController
  def new
    @senders = current_user.get_friend_senders
    @receivers = current_user.get_friend_receivers
  end

  def show
    @senders = current_user.get_friend_senders
    @receivers = current_user.get_friend_receivers
    @other_user = User.find(params[:user_id]) if params[:user_id]
    @group_chats = current_user.channels.group_chat
    @channel = Channel.find(params[:id])
    @message = Message.new
  end

  def create
    unless params[:user_id]
      flash[:notice] = "Please choose person!"
      redirect_back(fallback_location: root_path)
    else
      if params[:user_id].is_a? String # for private chat
        other_user = User.find(params[:user_id])
        channel = find_channel(other_user) || Channel.new
        if !channel.persisted?
          channel.save
          channel.subscriptions.create(user_id: current_user.id)
          channel.subscriptions.create(user_id: other_user.id)
        end
        redirect_to user_channel_path(other_user, channel)
      else # for public chat
        channel = Channel.new
        channel.name = params[:name]
        channel.save
        channel.subscriptions.create(user_id: current_user.id)
        params[:user_id].each do |id|
          channel.subscriptions.create(user_id: id)
        end
        redirect_to channel_path(channel)
      end
    end
  end

  private
  def find_channel(other_user)
  	current_user.channels.each do |channel|
  		channel.subscriptions.each do |subscription|
  			if subscription.user_id == other_user.id
          if channel.users.count == 2
    				return channel
          end
  			end
  		end
  	end
  	nil
  end
end
