class Ability
  include CanCan::Ability

  def initialize(user)
    if user && user.is?('admin')
      can :manage, :all
    end
  end
end
