class PostsController < ApplicationController

  def index
    page = params[:page] || 1
    if params[:category_id].nil?
      @posts = Post.published.page(page).per(global_settings.posts_per_page)
    else
      @category = site_categories.select{ |c| c.slug == params[:category_id] }.first
      unless @category.nil?
        @posts = Post.in_category(@category.id).page(page).per(global_settings.posts_per_page)
      else
        redirect_to root_url
      end
    end
  end

  def show
    @post = Post.find_by_slug params[:slug]
  end

end
