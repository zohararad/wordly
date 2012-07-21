class Comment < ActiveRecord::Base
  attr_protected :author_id, :post_id

  belongs_to :post
  belongs_to :author

  validates :post_id,          :presence => true
  validates :author_name,      :presence => true
  validates :comment,          :presence => true
  validates :author_email,     :allow_blank => true, :email => true
  validates :author_website,   :allow_blank => true, :uri => true

end
