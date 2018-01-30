class PagesController < ApplicationController
  def index
  	@posts = Post.all_active.includes(:user).where(users: { is_lock: false }).order("posts.created_at desc")
    @post = Post.new
  end
end
