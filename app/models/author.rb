class Author < ActiveRecord::Base

  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, 
         :recoverable, :rememberable, :trackable, :validatable

  attr_accessible :first_name, :last_name, :email, :website, :about, :meta, :remember_me, :password, :password_confirmation

  has_many :posts
  has_many :comments
  has_many :pages

  validates :first_name,    :presence => true,  :length => { :minimum => 2 }
  validates :last_name,     :presence => true,  :length => { :minimum => 2 }
  validates :email,         :presence => true,  :length => { :minimum => 3 }, :uniqueness => true, :email => true
  validates :website,       :allow_nil => true, :uri => true

  before_save :set_slug

  def full_name
    [first_name, last_name].compact.join(' ')
  end

  def to_s
    full_name
  end

  private

  def set_slug
    self.slug = [first_name.downcase, last_name.downcase].join('-')
  end
end
