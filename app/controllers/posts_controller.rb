class PostsController < ApplicationController
  before_action :get_post, only: [ :edit, :update, :destroy, :mark_remove, :unmark_remove ]
  before_action :require_admin, only: [ :lock ]

  @@minimum_report_count = 5
    
  def create
    @post = Post.new(post_params)
    @post.user_id = current_user.id
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

  def mark_remove
    if @post.reports.count > @@minimum_report_count
      @post.mark_remove
      if @post.save
        flash[:notice] = "Mark remove post complete!"
      else
        flash[:notice] = "Mark remove post failed!"
      end
    else
      flash[:notice] = "This post doesn't have more than #{@@minimum_report_count} reports!"
    end
    redirect_back(fallback_location: root_path)
  end

  def unmark_remove
    @post.unmark_remove
    if @post.save
      flash[:notice] = "Unmark remove post complete!"
    else
      flash[:notice] = "Unmark remove post failed!"
    end
    redirect_back(fallback_location: root_path)
  end
  
  private
  def post_params
    params.require(:post).permit(:user_id, :title, :content)
  end

  def get_post
    @post = Post.find(params[:id])
  end
end
