class PostsController < ApplicationController
  before_action :require_user
  before_action :get_post, only: [ :edit, :update, :destroy ]

	# def new 
 #     @post = Post.new
 #  end
    
  def create
    @post = Post.new(post_params)
    @post.user_id = current_user.id # assign the post to the user who created it.
    if @post.save
      flash[:notice] = "Create new post complete!"
    else
      flash[:notice] = "Create new post failed!"
    end
    redirect_back(fallback_location: root_path)
  end
    
  def edit
  end

  def update
    if @post.update_attributes(post_params)
      flash[:notice] = "Update post complete!"
      redirect_to root_path
    else
      flash[:notice] = "Update post failed!"
      render 'edit'
    end
  end

  def destroy
    @post.destroy
    flash[:notice] = "Delete post complete!"
    redirect_back(fallback_location: root_path)
  end
  
  private
  def post_params # allows certain data to be passed via form.
    params.require(:post).permit(:user_id, :title, :content)
  end

  def get_post
    @post = Post.find(params[:id])
  end
end
