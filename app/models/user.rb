class User < ActiveRecord::Base
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :rpx_connectable

  attr_accessible :email, :password, :password_confirmation, :remember_me
  
  has_many :donations
  has_many :projects, :through=>:donations
  
  def projects_i_have_contributed_to
    projects.uniq
  end
  
  def details
    [:first_name, :last_name, :email, :password].map {|field| self.send(field) }.reject(&:blank?).join(', ')
  end
end