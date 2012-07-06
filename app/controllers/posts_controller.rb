class PostsController < ApplicationController

  def index
    page = params[:page] || 1
    @posts = Post.where(:published => 1).page(page).per(global_settings.posts_per_page)
  end

  def show
    @post = Post.find_by_slug params[:slug]
  end

end
