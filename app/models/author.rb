class Author < ActiveRecord::Base

  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, 
         :recoverable, :rememberable, :trackable, :validatable

  attr_accessible :first_name, :last_name, :email, :website, :about, :meta, :remember_me

  has_many :posts
  has_many :comments
  has_many :pages

  def full_name
    [first_name, last_name].join(' ')
  end

  def to_s
    full_name
  end
end
