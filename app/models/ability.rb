class Ability
  include CanCan::Ability

  def initialize(user)
    if user && user.is?('site_admin')
      can :manage, :all
    end
  end
end
