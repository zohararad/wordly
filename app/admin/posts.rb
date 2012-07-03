ActiveAdmin.register Post do

  form :partial => "form"

  controller do

    def create
      @post = Post.new params[:post]
      @post.author = current_author
      if @post.save
        flash[:notice] = 'Post was created successfully'
        redirect_to edit_admin_post_path @post
      else
        render :new
      end
    end

  end

end
