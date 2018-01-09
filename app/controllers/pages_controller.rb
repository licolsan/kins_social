class PagesController < ApplicationController
	before_action :require_user
  def index
  	@posts = Post.all
    @post = Post.new
  end
end
