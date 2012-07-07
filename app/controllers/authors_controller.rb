class AuthorsController < ApplicationController

  def show
    @author = Author.find_by_slug(params[:slug])
    @author_posts = Post.latest_by_author(@author.id)
  end
end
