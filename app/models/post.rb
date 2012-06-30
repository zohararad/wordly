class Post < ActiveRecord::Base
  attr_protected :author_id
  #acts_as_taggable_on :tags

  belongs_to :author
  has_many :comments
  #has_and_belongs_to_many :channels

end
