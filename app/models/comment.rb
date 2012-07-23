class Comment < ActiveRecord::Base
  attr_protected :author_id, :post_id

  belongs_to :post
  belongs_to :author

  after_create  :increment_comment_count
  after_destroy :decrement_comment_count

  validates :post_id,          :presence => true
  validates :author_name,      :allow_blank => false, :length => { :minimum => 1, :too_short => "Your name is required" }
  validates :comment,          :allow_blank => false, :length => { :minimum => 1, :too_short => "You forgot to write a comment" }
  validates :author_email,     :allow_blank => false, :email => { :message => 'A valid email address is required' }
  validates :author_website,   :allow_blank => true, :uri => { :message => 'A valid URL is required' }

  private

  def increment_comment_count
    self.post.comment_count += 1
    self.post.save
  end

  def decrement_comment_count
    self.post.comment_count = [self.post.comment_count - 1, 0].max
    self.post.save
  end

end
