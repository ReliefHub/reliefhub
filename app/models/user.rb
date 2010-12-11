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

  ROLES =%w[site_admin field_operator organization_manager visitor]

  # http://github.com/ryanb/cancan/wiki/role-based-authorization
  def roles=(roles)
    self.roles_mask = (roles & ROLES).map { |r| 2**ROLES.index(r) }.sum
  end

  def roles
    ROLES.reject do |r|
      ((roles_mask || 0) & 2**ROLES.index(r)).zero?
    end
  end

  def is?(role)
    roles.include?(role.to_s)
  end

  def display_name
    "#{first_name} #{last_name}"
  end

  def unique_projects
    projects.uniq
  end

  def update_with_password(params={})
    params.delete(:password)              if params[:password].blank?
    params.delete(:password_confirmation) if params[:password_confirmation].blank?
    update_attributes(params)
  end
end
