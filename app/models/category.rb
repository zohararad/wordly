class Category < ActiveRecord::Base
  has_and_belongs_to_many :posts

  attr_accessible :name, :slug

  def to_s
    name
  end

end
