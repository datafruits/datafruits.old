class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new # guest user (not logged in)
    if user.admin?
      can :manage, :all
    elsif user.blogger?
      can :manage, Post
      can :manage, User, :id => user.id
      can :manage, Show, :user_id => user.id
    elsif user.dj?
      can :manage, User, :id => user.id
      can :manage, Show, :user_id => user.id
    else
      can :read, Show
    end
  end
end
