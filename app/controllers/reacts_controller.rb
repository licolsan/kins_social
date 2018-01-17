class ReactsController < ApplicationController
	before_action :find_post_or_comment, only: [ :create ]
	before_action :find_react, only: [ :destroy ]

	def create
		@react = @comment.reacts.new(react_params) if @comment
		@react = @post.reacts.new(react_params) if @post
		@react.user_id = current_user.id
		if @react.save
			flash[:notice] = "React successfully!"
		else
			flash[:notice] = "React failed!"
		end
		redirect_back(fallback_location: root_path)
	end

	def destroy
		@react.destroy
		flash[:notice] = "React terminated!"
		redirect_back(fallback_location: root_path)
	end

	private
	def react_params
		params.require(:react).permit(:react_type)
	end

	def find_react
		@react = React.find(params[:id])
	end

	def find_post_or_comment
		@comment = Comment.find(params[:comment_id]) if params[:comment_id]
		@post = Post.find(params[:post_id]) if params[:post_id]
	end
end
