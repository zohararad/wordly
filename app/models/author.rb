class Author < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, 
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :first_name, :last_name, :email, :website, :about, :meta, :remember_me
  # attr_accessible :title, :body

  def full_name
    [first_name, last_name].join(' ')
  end

  def to_s
    full_name
  end
end
