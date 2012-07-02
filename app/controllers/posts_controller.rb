class PostsController < ApplicationController

  def index
    page = params[:page] || 1
    @posts = Post.where(:published => 1).paginate(:page => page, :per_page => 20)
  end

  def show

  end

end
