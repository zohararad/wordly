class Comment < ActiveRecord::Base
  attr_protected :author_id, :post_id

  belongs_to :post
  belongs_to :author
end
