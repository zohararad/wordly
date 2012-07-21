class Category < ActiveRecord::Base
  attr_accessible :name, :slug

  has_and_belongs_to_many :posts

  validates :name,    :presence => true,  :length => { :minimum => 2 }, :uniqueness => true
  validates :slug,    :presence => true,  :length => { :minimum => 2 }, :uniqueness => true

  def to_s
    name
  end

end
