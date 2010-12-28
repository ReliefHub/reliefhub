module Admin::UsersHelper
  def display_if_is?(user, role)
    if user.is? role
      'Enabled'
    else
      'Disabled'
    end
  end
end

