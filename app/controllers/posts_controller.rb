class PostsController < ApplicationController

  def index
    page = params[:page] || 1
    if not params[:category_id].nil?
      @category = site_categories.select{ |c| c.slug == params[:category_id] }.first
      unless @category.nil?
        @posts = Post.in_category(@category.id, page, global_settings.posts_per_page)
      else
        redirect_to root_url
      end
    elsif not params[:tag_id].nil?
      @posts = Post.tagged_with(params[:tag_id]).published(page, global_settings.posts_per_page)
    else
      @posts = Post.published(page, global_settings.posts_per_page)
    end
  end

  def show
    @post = Post.find_by_slug params[:slug]
    @comment = Comment.new
  end

end
