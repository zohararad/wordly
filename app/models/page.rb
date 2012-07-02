class Page < ActiveRecord::Base
  attr_protected :author_id

  belongs_to :author
end
