class PagesController < ApplicationController
  def index
  	@posts = Post.all
    @post = Post.new
  end
end
