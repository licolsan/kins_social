class MessagesController < ApplicationController
	def create
		message = Message.new(message_params)
		message.user_id = current_user.id
		if message.save
			ActionCable.server.broadcast(
				"message_#{message_params[:channel_id]}",
				user: current_user.name,
				message: message.content
			)
		else
			flash[:notice] = "Send message failed!"
			redirect_to root_path
		end
	end

	private
	def message_params
		params.require(:message).permit(:content, :channel_id)
	end
end
