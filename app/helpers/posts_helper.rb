module PostsHelper

  # Finds the comment to which a user is currently replying if any
  # @param [Array] comments list of comments for current post
  # @return [Comment] comment to reply to or nil
  def get_reply_to_comment(comments)
    comments.select{|comment| comment.id.to_s == params[:reply_to_comment]}.first
  end

  # Renders the comment's list HTML
  # @param [Array] comments list of comments to generate HTML from
  # @param [Post] post the post to which all comments belong
  def get_comments(comments, post)
    tree = get_comments_tree(comments)
    get_comments_list(tree, post)
  end

  # Generates HTML for a UL element containing a list of comments
  # Called recursively to generate the complete comments HTML tree
  # @param [Array] comments list of comments
  # @param [Post] post the post to which all comments belong
  def get_comments_list(comments, post)
    if comments.any?
      content_tag(:ul, :class => 'comments-list') do
        comments.collect do |h|
          concat(content_tag(:li, :class => 'comment') do
            concat(gravatar_image(h[:comment][:author_email]))
            concat(simple_format(h[:comment].comment, :class => 'comment-text'))
            concat(content_tag(:p ,{:class => 'comment-meta'}) do
              concat(['By %s' % h[:comment].author_name, h[:comment].created_at.strftime(global_settings.date_format)].join(', '))
              concat(link_to 'Reply to this comment', post_url(post.slug, :reply_to_comment => h[:comment].id) + '#post-comment-form', :class => 'reply-to')
            end)
            concat(get_comments_list(h[:children],post)) if h[:children].any?
          end)
        end
      end
    end
  end

  # Generates a tree of comments with comment children
  # Used to render comments in their right hierarchy
  # @param [Array] comments list of comments to generate tree from
  # @return [Array] ordered tree of comments with comment children
  def get_comments_tree(comments)
    tree = []
    comments.each do |comment|
      children = comments.select { |c| c.hierarchy.starts_with?(comment.hierarchy + '-')}
      comments.reject! { |c| c.hierarchy.starts_with?(comment.hierarchy + '-')}
      h = {:comment => comment, :children => get_comments_tree(children) }
      tree << h
    end
    tree
  end

end
