class User < ActiveRecord::Base
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :rpx_connectable

  attr_accessible :email, :first_name, :last_name, :password, :password_confirmation, :remember_me

  has_many :donations
  has_many :projects, :through => :donations

  validates_presence_of :email
  validates_presence_of :first_name
  validates_presence_of :last_name

  def unique_projects
    projects.uniq
  end

  def update_with_password(params={})
    params.delete(:password)              if params[:password].blank?
    params.delete(:password_confirmation) if params[:password_confirmation].blank?
    update_attributes(params)
  end
end
