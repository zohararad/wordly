class Comment < ActiveRecord::Base
  attr_protected :author_id, :post_id

  belongs_to :post
  belongs_to :author

  after_create  :increment_comment_count
  after_destroy :decrement_comment_count

  validates :post_id,          :presence => true
  validates :author_name,      :presence => true
  validates :comment,          :presence => true
  validates :author_email,     :allow_blank => true, :email => true
  validates :author_website,   :allow_blank => true, :uri => true

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
