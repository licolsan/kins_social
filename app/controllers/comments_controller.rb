class CommentsController < ApplicationController
	before_action :find_post, only: [ :create ]
	before_action :find_comment, only: [ :edit, :update, :destroy ]

	def create
		@comment = @post.comments.create(comment_params)
		@comment.user_id = current_user.id
		if @comment.save
			flash[:notice] = "Your comment saved!"
		else
			flash[:notice] = "Comment meets error!"
		end
		redirect_back(fallback_location: root_path)
	end

	def edit
	end

	def update
		if @comment.update_attributes(comment_params)
			flash[:notice] = "Your comment has been updated!"
		else
			flash[:notice] = "Update comment failed!"
		end
		redirect_to root_path
	end

	def destroy
		@comment.destroy
		flash[:notice] = "Your comment has been deleted!"
		redirect_back(fallback_location: root_path)
	end

	private
	def comment_params
		params.require(:comment).permit(:content)
	end

	def find_comment
		@comment = Comment.find(params[:id])
	end

	def find_post
		@post = Post.find(params[:post_id])
	end
end
