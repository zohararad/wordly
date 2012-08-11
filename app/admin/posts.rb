ActiveAdmin.register Post do

  form :partial => "form"

  index do
    column :title
    column :author
    column :created_at
    default_actions
  end

  show do |post|
    h3 post.title
    h4 'By %s | %s' % [post.author, post.created_at.strftime('%d-%B-%Y %H:%M')]
    div do
      simple_format post.excerpt
    end
    div do
      span { link_to 'Edit post', edit_admin_post_url(post) }
      span { '&nbsp;|&nbsp;'.html_safe }
      span { link_to 'Back to posts', admin_posts_url }
    end
  end

  controller do

    def create
      @post = Post.new params[:post]
      @post.author = current_author
      if @post.save
        flash[:notice] = 'Post was created successfully'
        redirect_to edit_admin_post_path @post
      else
        @tags = Tag.all
        render :new
      end
    end

    def edit
      @tags = Tag.all
      super
    end

    def new
      @tags = Tag.all
      super
    end
  end

end
