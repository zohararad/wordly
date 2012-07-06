class Post < ActiveRecord::Base
  attr_protected :author_id
  acts_as_taggable_on :tags
  before_save :set_slug

  belongs_to :author
  has_many :comments
  has_and_belongs_to_many :categories

  # published posts
  scope :published, where(:published => 1).includes(:categories, :author)

  # posts in category
  scope :in_category, lambda {|category_id|
    where(["posts.published = 1 and categories_posts.category_id = ?", category_id]).joins(:categories, :author).includes(:categories, :author)
  }

  private

  def set_slug
    self.slug = self.title.downcase.parameterize if self.slug.blank?
  end
end
