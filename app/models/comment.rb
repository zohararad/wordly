class Comment < ActiveRecord::Base
  attr_protected :author_id, :post_id
  attr_accessor :comment_parent_id

  belongs_to :post
  belongs_to :author

  before_create :set_comment_hierarchy
  after_create  :set_default_hierarchy
  after_create  :increment_comment_count
  after_destroy :decrement_comment_count

  validates :post_id,          :presence => true
  validates :author_name,      :allow_blank => false, :length => { :minimum => 1, :too_short => "Your name is required" }
  validates :comment,          :allow_blank => false, :length => { :minimum => 1, :too_short => "You forgot to write a comment" }
  validates :author_email,     :allow_blank => false, :email => { :message => 'A valid email address is required' }
  validates :author_website,   :allow_blank => true, :uri => { :message => 'A valid URL is required' }

  default_scope order('hierarchy asc')

  scope :recent, lambda {|c| order('created_at desc').limit(c) }

  private

  def increment_comment_count
    self.post.comment_count += 1
    self.post.save
  end

  def decrement_comment_count
    self.post.comment_count = [self.post.comment_count - 1, 0].max
    self.post.save
  end

  def set_comment_hierarchy
    unless comment_parent_id.nil?
      reply_to_comment = Comment.find(comment_parent_id)
      self.hierarchy = [reply_to_comment.hierarchy,reply_to_comment.id].compact.join('-')
    end
  end

  def set_default_hierarchy
    self.update_attribute(:hierarchy, self.id) if self.hierarchy.nil?
  end

end
