class User < ActiveRecord::Base
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :rpx_connectable

  attr_accessible :email, :password, :password_confirmation, :remember_me
end
