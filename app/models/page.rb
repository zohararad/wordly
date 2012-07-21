class Page < ActiveRecord::Base
  attr_protected :author_id

  belongs_to :author

  validates :title,       :presence => true, :length => { :minimum => 2 }
  validates :slug,        :presence => true, :uniqueness => true
  validates :content,     :presence => true, :length => { :minimum => 2 }
  validates :author_id,   :presence => true

end
