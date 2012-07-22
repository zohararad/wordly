class PostsController < ApplicationController

  def index
    page = params[:page] || 1
    if not params[:category_id].nil?
      @category = site_categories.select{ |c| c.slug == params[:category_id] }.first
      unless @category.nil?
        @posts = Post.in_category(@category.id).page(page).per(global_settings.posts_per_page)
      else
        redirect_to root_url
      end
    elsif not params[:tag_id].nil?
      @posts = Post.tagged_with(params[:tag_id]).published.page(page).per(global_settings.posts_per_page)
    else
      @posts = Post.published.page(page).per(global_settings.posts_per_page)
    end
  end

  def show
    @post = Post.find_by_slug params[:slug]
  end

  def update
    id = Post.id_from_uid(params[:id])
    post = Post.find(id)
    unless post.nil?
      comment = Comment.new params[:post][:comment]
      comment.post_id = post.id
      comment.author_id = current_author.id unless current_author.nil?
      comment.author_ip = request.remote_ip
      if comment.save!
        post.comment_count += 1
        post.save
      end
      redirect_to post_url(post.slug)
    end
  end

end
