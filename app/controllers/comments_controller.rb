class CommentsController < ApplicationController

  def create
    id = Post.id_from_uid(params[:comment].delete(:uid))
    @post = Post.find(id)
    unless @post.nil?
      @comment = Comment.new params[:comment]
      @comment.post_id = @post.id
      @comment.author_id = current_author.id unless current_author.nil?
      @comment.author_ip = request.remote_ip
      if @comment.save
        flash[:notice] = 'Comment successfully saved'
        redirect_to post_url(@post.slug)
      else
        flash[:error] = 'Comment was not saved'
        render 'posts/show'
      end
    end
  end

end