class Post < ActiveRecord::Base

  include ActionView::Helpers::SanitizeHelper

  attr_protected :author_id
  acts_as_taggable_on :tags
  after_create :set_uid
  before_save :set_slug

  belongs_to :author
  has_many :comments
  has_and_belongs_to_many :categories

  validates :title,    :presence => true,  :length => { :minimum => 2 }
  validates :content,  :presence => true,  :length => { :minimum => 10 }
  validates :excerpt,                      :length => { :minimum => 2 }, :allow_blank => true
  validates :slug,     :uniqueness => true, :allow_nil => false

  # published posts
  scope :published, lambda{|page, per_page|
    where(:published => 1).includes(:categories, :author).page(page).per(per_page)
  }

  # posts in category
  scope :in_category, lambda {|category_id, page, per_page|
    where(["posts.published = 1 and categories_posts.category_id = ?", category_id])
    .joins(:categories, :author)
    .includes(:categories, :author)
    .page(page)
    .per(per_page)
  }

  # Latest posts by author
  scope :latest_by_author, lambda { |author_id|
    where(['author_id = ?', author_id]).order('created_at desc').limit(10)
  }

  scope :recent, lambda {|c| order('updated_at desc').limit(c) }
  # Returns either the post's excerpt or a stripped version of the post's content in case the excerpt is blank
  # @return [String] excerpt or stripped version of post content
  def post_excerpt
    excerpt.blank? ? strip_tags(content.gsub(/<\/([^>]+)>/,"</$1> ")).split(' ')[0..30].join(' ') + '...' : excerpt
  end

  # Generates a uid from a Base64 encoded version of id and a random salt
  # @return [String] uid
  def uid_from_id
    salt = rand(36**8).to_s(36)
    str = [salt, self.id].join('')
    Base64::encode64(str).gsub(/\n/,'')
  end

  # Decodes uid and extracts that record id part of the decoded string
  # @param [String] uid - uid to decode
  # @return [Interger] record id
  def self.id_from_uid(uid)
    Base64::decode64(uid)[8..-1].to_i
  end

  private

  # Sets a unique id to a post that is used to obfuscate the record's id in forms and urls
  # Called after record creation
  def set_uid
    self.uid = uid_from_id
    self.save
  end

  # Sets the post's slug to a parameterized version of the title in case the slug is blank
  def set_slug
    self.slug = self.title.downcase.parameterize if self.slug.blank?
  end
end
