class User < ActiveRecord::Base
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :rpx_connectable

  attr_accessible :email, :first_name, :last_name, :password, :password_confirmation, :remember_me
  
  has_many :donations
  has_many :projects, :through=>:donations

  validates_presence_of :email
  validates_presence_of :first_name
  validates_presence_of :last_name
  
  def projects_i_have_contributed_to
    projects.uniq
  end
end