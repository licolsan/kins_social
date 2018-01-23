class MessagesChannel < ApplicationCable::Channel
  def subscribed
    stream_from "message_#{params[:channel_id]}"
  end

  def unsubscribed
  end
end
